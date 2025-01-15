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
	^ isLocked
]

{ #category : #accessing }
VirtualMachineSemaphoreWaitTelemetrySignal >> statusText [
	^ self isLocked
		ifTrue: [ 'Waiting on a locked semaphore' asRopedText foreground: BrGlamorousColors failureBorderColor ]
		ifFalse: [ 'Passing by an unlocked semaphore' asRopedText foreground: BrGlamorousColors formLabelTextColor ]
]
