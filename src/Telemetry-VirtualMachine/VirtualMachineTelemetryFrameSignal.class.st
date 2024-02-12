Class {
	#name : #VirtualMachineTelemetryFrameSignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'timestamp',
		'framePointer'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryFrameSignal >> framePointer [
	^ framePointer
]

{ #category : #accessing }
VirtualMachineTelemetryFrameSignal >> timestamp [
	"Amount of nanoseconds since the creation of telemetry"
	^ timestamp
]
