Class {
	#name : #VirtualMachineComputationTelemetrySignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'object',
		'isStart'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineComputationTelemetrySignal >> isEnd [
	^ isStart not
]

{ #category : #'as yet unclassified' }
VirtualMachineComputationTelemetrySignal >> isStart [
	^ isStart
]

{ #category : #'as yet unclassified' }
VirtualMachineComputationTelemetrySignal >> value [
	^ object
]
