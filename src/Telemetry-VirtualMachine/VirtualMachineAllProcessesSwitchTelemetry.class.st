Class {
	#name : #VirtualMachineAllProcessesSwitchTelemetry,
	#superclass : #Object,
	#instVars : [
		'id',
		'startTime',
		'signalsDictionary',
		'contextSwitchSignalClass',
		'semaphoreWaitSignalClass',
		'orderedCollectionClass'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry class >> spyFor: aDuration [
	<return: #VirtualMachineTelemetry>
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
	<return: #VirtualMachineTelemetry>
	| aTelemetry |

	aTelemetry := self basicNewPinned
		initialize;
		yourself.
	
	[
		aTelemetry start.
		aBlock value ] ensure: [ aTelemetry stop ].
	^ aTelemetry
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
VirtualMachineAllProcessesSwitchTelemetry >> eventsIn: aCollection [
	| allEvents |
	allEvents := (self pauseEventsIn: aCollection), (self resumeEventsIn: aCollection).
	^ allEvents
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> gtProcessesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Signals by process';
		priority: 7;
		object: [ self eventsByProcess ];
		view: #gtProcessesFor:
]

{ #category : #'as yet unclassified' }
VirtualMachineAllProcessesSwitchTelemetry >> gtTimelineFor: aView [
	<gtView>
	^ aView forward
		title: 'Timeline';
		priority: 5;
		object: [ self eventsByProcess ];
		view: #gtTimelineFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect events'
			action: [ :aButton | aButton phlow spawnObject: self eventsByProcess ]
]

{ #category : #'as yet unclassified' }
VirtualMachineAllProcessesSwitchTelemetry >> initialize [
	super initialize.

	id := 0.
	signalsDictionary := VirtualMachineTelemetryIdentityDictionary new.
	contextSwitchSignalClass := VirtualMachineProcessSwitchTelemetrySignal.
	semaphoreWaitSignalClass := VirtualMachineSemaphoreWaitTelemetrySignal.
	orderedCollectionClass := OrderedCollection
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
VirtualMachineAllProcessesSwitchTelemetry >> resumeEventsIn: aCollection [
	| resumeEvents resumeSignal |
	
	resumeEvents := OrderedCollection new.
	
	resumeSignal := nil.
	
	aCollection do: [ :eachSignal |
		(eachSignal isKindOf: VirtualMachineProcessSwitchTelemetrySignal)
			ifTrue: [
				eachSignal isResumed
					ifTrue: [ resumeSignal := eachSignal ].

				(eachSignal isPaused and: [ resumeSignal isNotNil ])
					ifTrue: [
						resumeEvents add: (VirtualMachineTelemetryProcessResumedEvent new
							startSignal: resumeSignal;
							endSignal: eachSignal).
						
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
