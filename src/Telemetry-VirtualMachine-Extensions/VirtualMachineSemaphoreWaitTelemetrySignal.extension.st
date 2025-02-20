Extension { #name : #VirtualMachineSemaphoreWaitTelemetrySignal }

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineSemaphoreWaitTelemetrySignal >> statusText [
	^ self isLocked
		ifTrue: [ 'Waiting on a locked semaphore' asRopedText foreground: BrGlamorousColors failureBorderColor ]
		ifFalse: [ 'Passing by an unlocked semaphore' asRopedText foreground: BrGlamorousColors formLabelTextColor ]
]
