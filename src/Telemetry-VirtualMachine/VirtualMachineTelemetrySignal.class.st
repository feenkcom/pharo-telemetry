Class {
	#name : #VirtualMachineTelemetrySignal,
	#superclass : #Object,
	#instVars : [
		'framePointer'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetrySignal >> accept: aVisitor [
]

{ #category : #accessing }
VirtualMachineTelemetrySignal >> framePointer [
	^ framePointer
]

{ #category : #testing }
VirtualMachineTelemetrySignal >> isReturnSignal [
	^ false
]
