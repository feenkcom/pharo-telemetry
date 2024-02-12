Class {
	#name : #VirtualMachineTelemetrySignal,
	#superclass : #Object,
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetrySignal >> accept: aVisitor [
]

{ #category : #accessing }
VirtualMachineTelemetrySignal >> framePointer [
	^ nil
]

{ #category : #testing }
VirtualMachineTelemetrySignal >> isDebugSignal [
	^ false
]

{ #category : #testing }
VirtualMachineTelemetrySignal >> isReturnSignal [
	^ false
]

{ #category : #accessing }
VirtualMachineTelemetrySignal >> sourceIdName [
	^ ''
]
