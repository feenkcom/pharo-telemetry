Class {
	#name : #VirtualMachineTelemetryContextSwitchSignal,
	#superclass : #VirtualMachineTelemetryFrameSignal,
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryContextSwitchSignal >> accept: aVisitor [
	aVisitor visitContextSwitch: self
]
