Class {
	#name : #VirtualMachineSemaphoreWaitTelemetrySignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'semaphore',
		'isLocked'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #testing }
VirtualMachineSemaphoreWaitTelemetrySignal >> isLocked [
	^ isLocked and: [ semaphore isKindOf: AsyncSemaphoreForMutualExclusion ]
]

{ #category : #testing }
VirtualMachineSemaphoreWaitTelemetrySignal >> isWaiting [
	^ isLocked
]

{ #category : #accessing }
VirtualMachineSemaphoreWaitTelemetrySignal >> semaphore [
	^ semaphore
]

{ #category : #accessing }
VirtualMachineSemaphoreWaitTelemetrySignal >> statusText [
	^ self isLocked
		ifTrue: [ 'Waiting on a locked semaphore' asRopedText foreground: BrGlamorousColors failureBorderColor ]
		ifFalse: [ 'Passing by an unlocked semaphore' asRopedText foreground: BrGlamorousColors formLabelTextColor ]
]
