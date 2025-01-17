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
			ensure: [ aTelemetry stop ] ] forkAt: Processor highestPriority.

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
VirtualMachineAllProcessesSwitchTelemetry >> eventsIn: aCollection [
	| allEvents |
	allEvents := (self pauseEventsIn: aCollection), (self resumeEventsIn: aCollection).
	^ allEvents
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> gtPauseEventsFor: aView [
	"<gtView>"
	
	^ aView columnedList
		title: 'Pauses';
		priority: 1;
		items: [ self pauseEvents ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Duration' 
			text: [ :eachItem | eachItem duration gtPreciseHumanReadableString ];
		column: 'Reason'
			text: [ :eachItem | eachItem printHumanReadablePauseReason ];
		column: 'Timestamp'
			text: [ :eachItem | eachItem startTime ];
		actionUpdateButton
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> gtProcessesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Signals by process';
		priority: 7;
		items: [ (signalsDictionary associations sorted: [ :a :b | a key priority > b key priority ]) ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Process' 
			text: [ :eachItem | eachItem key gtName ]
			weight: 0.6;
		column: 'Priority' 
			text: [ :eachItem | eachItem key priority ]
			width: 60;
		column: 'Amount of signals'
			text: [ :eachItem | eachItem value size ]
			weight: 0.4;
		send: [ :eachItem | eachItem value ];
		actionUpdateButton
]

{ #category : #accessing }
VirtualMachineAllProcessesSwitchTelemetry >> gtSignalsFor: aView [
	"<gtView>"
	
	^ aView columnedList
		title: 'Signals';
		priority: 2;
		items: [ self signals ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Status' 
			text: [ :eachItem | eachItem statusText ];
		column: 'Timestamp'
			text: [ :eachItem | eachItem timestamp ];
		actionUpdateButton
]

{ #category : #'as yet unclassified' }
VirtualMachineAllProcessesSwitchTelemetry >> gtTimelineFor: aView [
	<gtView>
	^ aView explicit
		title: 'Timeline';
		priority: 5;
		stencil: [
			GtMonitorFutureWorkerHorizontalChartStencil new
				leftPadding: 20;
				labelWidth: 250;
				labelFontSize: 12;
				rowHeight: 20;
				barHeight: 10;
				withoutGridlines;
				withoutTickLabels;
				startTimeComputation: #startTime;
				endTimeComputation: #endTime;
				colorComputation: [ :each |
					each isResumedEvent
						ifTrue: [ Color blue ]
						ifFalse: [ each isWaitingOnSemaphore
							ifTrue: [ Color orange ]
							ifFalse: [ Color veryVeryLightGray ] ] ];
				executionGeometryComputation: [ :each | BlRectangleGeometry new ];
				rowValuesComputation: #signals;
				rowLabelComputation: [ :each | each process gtName ];
				executions: self signalsByProcess ];
		actionUpdateButton
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
			and: [ eachSignal isLocked ])
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

{ #category : #'as yet unclassified' }
VirtualMachineAllProcessesSwitchTelemetry >> signalsByProcess [
	^ ((signalsDictionary associations sorted: [ :a :b | a key priority > b key priority ])
		collect: [ :each | each key -> (self eventsIn: each value) ]
		thenSelect: [ :each | each value isNotEmpty ])
			collect: [ :each |
				VirtualMachineTelemetrySignalsByProcess new
					process: each key;
					signals: each value ]
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
