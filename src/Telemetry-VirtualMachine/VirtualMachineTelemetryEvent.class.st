Class {
	#name : #VirtualMachineTelemetryEvent,
	#superclass : #Object,
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #testing }
VirtualMachineTelemetryEvent >> isComputationEvent [
	^ false
]

{ #category : #testing }
VirtualMachineTelemetryEvent >> isPausedEvent [
	^ false
]

{ #category : #testing }
VirtualMachineTelemetryEvent >> isResumedEvent [
	^ false
]
