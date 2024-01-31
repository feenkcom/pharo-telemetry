Class {
	#name : #VirtualMachineTelemetrySignal,
	#superclass : #Object,
	#instVars : [
		'timestamp',
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

{ #category : #accessing }
VirtualMachineTelemetrySignal >> timestamp [
	"Amount of nanoseconds since the creation of telemetry"
	^ timestamp
]
