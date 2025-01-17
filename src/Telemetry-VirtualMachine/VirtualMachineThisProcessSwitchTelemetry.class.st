Class {
	#name : #VirtualMachineThisProcessSwitchTelemetry,
	#superclass : #Object,
	#instVars : [
		'id',
		'signals',
		'currentProcess',
		'contextSwitchSignalClass',
		'semaphoreWaitSignalClass'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineThisProcessSwitchTelemetry class >> spyOn: aBlock [
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

{ #category : #accessing }
VirtualMachineThisProcessSwitchTelemetry >> gtPauseEventsFor: aView [
	<gtView>
	
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
VirtualMachineThisProcessSwitchTelemetry >> gtSignalsFor: aView [
	<gtView>
	
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
VirtualMachineThisProcessSwitchTelemetry >> initialize [
	super initialize.

	id := 0.
	signals := OrderedCollection new: 250.
	currentProcess := Processor activeProcess.
	contextSwitchSignalClass := VirtualMachineProcessSwitchTelemetrySignal.
	semaphoreWaitSignalClass := VirtualMachineSemaphoreWaitTelemetrySignal
]

{ #category : #'as yet unclassified' }
VirtualMachineThisProcessSwitchTelemetry >> pauseEvents [
	| pausedEvents pauseSignal pauseReason |
	
	pausedEvents := OrderedCollection new.
	
	pauseSignal := nil.
	pauseReason := nil.
	
	signals do: [ :eachSignal |
		(eachSignal isKindOf: VirtualMachineProcessSwitchTelemetrySignal)
			ifTrue: [
				eachSignal isPaused
					ifTrue: [ pauseSignal := eachSignal ].
					
				eachSignal isResumed
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
VirtualMachineThisProcessSwitchTelemetry >> primStartTelemetry [
	<primitive: #primitiveStartLocalProcessSwitchTelemetry>
	
	^ self primitiveFailed
]

{ #category : #'private - primitives' }
VirtualMachineThisProcessSwitchTelemetry >> primStopTelemetry: anId [
	<primitive: #primitiveStopTelemetry>
	
	^ self primitiveFailed
]

{ #category : #accessing }
VirtualMachineThisProcessSwitchTelemetry >> signals [
	^ signals
]

{ #category : #accessing }
VirtualMachineThisProcessSwitchTelemetry >> start [
	self primStartTelemetry
]

{ #category : #accessing }
VirtualMachineThisProcessSwitchTelemetry >> stop [
	self primStopTelemetry: id.
	self setPinnedInMemory: false
]
