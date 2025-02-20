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
VirtualMachineTelemetrySignal >> timestamp [
	^ (DateAndTime fromUnixTime: seconds)
		setNanoSeconds: nanos;
		yourself
]

{ #category : #accessing }
VirtualMachineTelemetrySignal >> timestamp: aDateAndTime [
	seconds := aDateAndTime asUnixTime.
	nanos := aDateAndTime nanoSecond
]
