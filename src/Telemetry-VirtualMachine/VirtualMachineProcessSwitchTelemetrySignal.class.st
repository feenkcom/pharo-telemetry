Class {
	#name : #VirtualMachineProcessSwitchTelemetrySignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'alive'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineProcessSwitchTelemetrySignal >> isAlive: aBoolean [
	alive := aBoolean
]

{ #category : #testing }
VirtualMachineProcessSwitchTelemetrySignal >> isPaused [
	^ alive not
]

{ #category : #testing }
VirtualMachineProcessSwitchTelemetrySignal >> isResumed [
	^ alive
]

{ #category : #accessing }
VirtualMachineProcessSwitchTelemetrySignal >> statusText [
	^ self isPaused
		ifTrue: [ 'Paused' asRopedText foreground: BrGlamorousColors linkWithErrorColor ]
		ifFalse: [ 'Resumed' asRopedText foreground: BrGlamorousColors successBorderColor ]
]
