Class {
	#name : #VirtualMachineTelemetrySignal,
	#superclass : #Object,
	#instVars : [
		'seconds',
		'nanos'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetrySignal >> statusText [
	^ self printString
]

{ #category : #accessing }
VirtualMachineTelemetrySignal >> timestamp [
	^ (DateAndTime fromUnixTime: seconds)
		setNanoSeconds: nanos;
		yourself
]
