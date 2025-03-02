Extension { #name : #VirtualMachineSemaphoreWaitTelemetrySignal }

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineSemaphoreWaitTelemetrySignal >> statusText [
	self isWaitingOnFuture
		ifTrue: [ ^ 'Waiting synchronously on a future' asRopedText foreground: BrGlamorousColors errorBorderColor ].
	
	self isLockedOnMonitor
		ifTrue: [ ^ 'Waiting on a locked monitor' asRopedText foreground: BrGlamorousColors failureBorderColor ].

	^ self isLocked
		ifTrue: [ 'Waiting on a locked semaphore' asRopedText foreground: BrGlamorousColors failureBorderColor ]
		ifFalse: [ 'Passing by an unlocked semaphore' asRopedText foreground: BrGlamorousColors formLabelTextColor ]
]
