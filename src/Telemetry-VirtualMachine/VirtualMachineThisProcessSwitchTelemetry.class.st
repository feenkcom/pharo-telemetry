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

{ #category : #initialization }
VirtualMachineThisProcessSwitchTelemetry >> initialize [
	super initialize.

	id := 0.
	signals := OrderedCollection new: 250.
	currentProcess := Processor activeProcess.
	contextSwitchSignalClass := VirtualMachineProcessSwitchTelemetrySignal.
	semaphoreWaitSignalClass := VirtualMachineSemaphoreWaitTelemetrySignal
]

{ #category : #accessing }
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
			and: [ eachSignal isWaiting ])
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
