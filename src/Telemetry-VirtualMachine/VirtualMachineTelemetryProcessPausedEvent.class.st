Class {
	#name : #VirtualMachineTelemetryProcessPausedEvent,
	#superclass : #VirtualMachineTelemetryEvent,
	#instVars : [
		'startSignal',
		'endSignal',
		'reasonSignal'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessPausedEvent >> duration [
	^ self endTime - self startTime
]

{ #category : #accessing }
VirtualMachineTelemetryProcessPausedEvent >> endSignal [
	^ endSignal
]

{ #category : #accessing }
VirtualMachineTelemetryProcessPausedEvent >> endSignal: anObject [
	endSignal := anObject
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessPausedEvent >> endTime [
	^ endSignal timestamp
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessPausedEvent >> isLockedOnSemaphore [
	^ (reasonSignal isKindOf: VirtualMachineSemaphoreWaitTelemetrySignal)
			and: [ reasonSignal isLocked ]
]

{ #category : #testing }
VirtualMachineTelemetryProcessPausedEvent >> isPausedEvent [
	^ true
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessPausedEvent >> isWaitingOnSemaphore [
	^ (reasonSignal isKindOf: VirtualMachineSemaphoreWaitTelemetrySignal)
			and: [ reasonSignal isWaiting ]
]

{ #category : #accessing }
VirtualMachineTelemetryProcessPausedEvent >> reasonSignal [
	^ reasonSignal
]

{ #category : #accessing }
VirtualMachineTelemetryProcessPausedEvent >> reasonSignal: anObject [
	reasonSignal := anObject
]

{ #category : #accessing }
VirtualMachineTelemetryProcessPausedEvent >> startSignal [
	^ startSignal
]

{ #category : #accessing }
VirtualMachineTelemetryProcessPausedEvent >> startSignal: anObject [
	startSignal := anObject
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessPausedEvent >> startTime [
	^ startSignal timestamp
]
