Class {
	#name : #VirtualMachineTelemetryContextSwitchSignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryContextSwitchSignal >> accept: aVisitor [
	aVisitor visitContextSwitch: self
]
