Extension { #name : #VirtualMachineTelemetryProcessPausedEvent }

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineTelemetryProcessPausedEvent >> printHumanReadablePauseReason [
	^ reasonSignal
		ifNil: [ 'Scheduler' asRopedText foreground: BrGlamorousColors fadedTextColor ]
		ifNotNil: [ :aSignal |
			self isWaitingOnSemaphore
				ifTrue: [ 'Locked semaphore' asRopedText foreground: BrGlamorousColors failureBorderColor ]
				ifFalse: [ aSignal printString ]
		]
]
