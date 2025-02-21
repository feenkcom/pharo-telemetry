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
