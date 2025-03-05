Class {
	#name : #VirtualMachineAllProcessesSwitchTelemetry,
	#superclass : #Object,
	#instVars : [
		'id',
		'startTime',
		'signalsDictionary',
		'contextSwitchSignalClass',
		'semaphoreWaitSignalClass',
		'objectSignalClass',
		'contextSignalClass',
		'orderedCollectionClass'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry class >> spyFor: aDuration [
	<return: #VirtualMachineAllProcessesSwitchTelemetry>
	| aTelemetry |

	aTelemetry := self basicNewPinned
		initialize;
		yourself.
	[ [
		aTelemetry start.
		aDuration wait ]
			ensure: [
				aTelemetry stop.
				self inform: 'Telemetry Finished' ] ] forkAt: Processor highestPriority.

	^ aTelemetry
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry class >> spyOn: aBlock [
	<return: #VirtualMachineAllProcessesSwitchTelemetry>
	| aTelemetry |

	aTelemetry := self basicNewPinned
		initialize;
		yourself.
	
	[
		aTelemetry start.
		aBlock value ] ensure: [ aTelemetry stop ].
	^ aTelemetry
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> computationEventsIn: aCollection [
	| customEvents eventsStack |
	
	customEvents := OrderedCollection new.
	eventsStack := Stack new.
	
	aCollection do: [ :eachSignal |
		(eachSignal isKindOf: VirtualMachineComputationTelemetrySignal)
			ifTrue: [
				eachSignal isStart
					ifTrue: [
						eventsStack push: (VirtualMachineTelemetryProcessComputationEvent new
							startSignal: eachSignal;
							yourself) ].

				(eachSignal isEnd and: [ eventsStack isNotEmpty ])
					ifTrue: [
						| anEvent |
						
						anEvent := eventsStack pop.
						anEvent endSignal: eachSignal.
						
						eventsStack isNotEmpty
							ifTrue: [
								eventsStack top addEvent: anEvent
							]
							ifFalse: [ customEvents add: anEvent ].
						
						 ] ] ].

	^ customEvents
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> eventsByProcess [
	| allEvents |
	
	allEvents := ((signalsDictionary associations sorted: [ :a :b | a key priority > b key priority ])
		collect: [ :each | each key -> (self eventsIn: each value) ]
		thenSelect: [ :each | each value isNotEmpty ])
			collect: [ :each |
				VirtualMachineTelemetryEvents new
					process: each key;
					addEvents: each value ].

	^ VirtualMachineTelemetryEventsByProcess new
		addAll: allEvents;
		yourself
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> eventsIn: aCollection [
	| allEvents |
	allEvents := (self pauseEventsIn: aCollection), (self resumeEventsIn: aCollection), (self computationEventsIn: aCollection).
	^ allEvents
]

{ #category : #initialization }
VirtualMachineAllProcessesSwitchTelemetry >> initialize [
	super initialize.

	id := 0.
	signalsDictionary := VirtualMachineTelemetryIdentityDictionary new.
	contextSwitchSignalClass := VirtualMachineProcessSwitchTelemetrySignal.
	semaphoreWaitSignalClass := VirtualMachineSemaphoreWaitTelemetrySignal.
	objectSignalClass := VirtualMachineComputationTelemetrySignal.
	contextSignalClass := VirtualMachineContextStackSignal.
	orderedCollectionClass := OrderedCollection
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> pauseEventsIn: aCollection [
	| pausedEvents pauseSignal pauseReason |
	
	pausedEvents := OrderedCollection new.
	
	pauseSignal := nil.
	pauseReason := nil.
	
	aCollection do: [ :eachSignal |
		(eachSignal isKindOf: VirtualMachineProcessSwitchTelemetrySignal)
			ifTrue: [
				eachSignal isPaused
					ifTrue: [ pauseSignal := eachSignal ].
					
				(eachSignal isResumed and: [ pauseSignal isNotNil ])
					ifTrue: [
						pausedEvents add: (VirtualMachineTelemetryProcessPausedEvent new
							startSignal: pauseSignal;
							endSignal: eachSignal;
							reasonSignal: pauseReason).
						
						pauseSignal := nil.
						pauseReason := nil ] ]
			ifFalse: [ pauseReason := nil ].

		((eachSignal isKindOf: VirtualMachineSemaphoreWaitTelemetrySignal)
			and: [ eachSignal isWaiting ])
				ifTrue: [ pauseReason := eachSignal ] ].

	^ pausedEvents
]

{ #category : #'private - primitives' }
VirtualMachineAllProcessesSwitchTelemetry >> primStartTelemetry [
	<primitive: #primitiveStartGlobalProcessSwitchTelemetry>
	
	^ self primitiveFailed
]

{ #category : #'private - primitives' }
VirtualMachineAllProcessesSwitchTelemetry >> primStopTelemetry: anId [
	<primitive: #primitiveStopTelemetry>
	
	^ self primitiveFailed
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> resumeEventsIn: aCollection [
	| resumeEvents resumeSignal customSignals |
	
	resumeEvents := OrderedCollection new.
	resumeSignal := nil.
	customSignals := OrderedCollection new.
	
	aCollection do: [ :eachSignal |
		(eachSignal isKindOf: VirtualMachineContextStackSignal)
			ifTrue: [ customSignals add: eachSignal ].
	
		(eachSignal isKindOf: VirtualMachineProcessSwitchTelemetrySignal)
			ifTrue: [
				eachSignal isResumed
					ifTrue: [ resumeSignal := eachSignal ].

				(eachSignal isPaused and: [ resumeSignal isNotNil ])
					ifTrue: [
						resumeEvents add: (VirtualMachineTelemetryProcessResumedEvent new
							startSignal: resumeSignal;
							endSignal: eachSignal;
							events: customSignals;
							yourself).
						
						customSignals := OrderedCollection new.
						
						resumeSignal := nil ] ] ].

	^ resumeEvents
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> signals [
	^ signalsDictionary
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> start [
	startTime := DateAndTime now.
	self primStartTelemetry
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> stop [
	self primStopTelemetry: id.
	self setPinnedInMemory: false
]
