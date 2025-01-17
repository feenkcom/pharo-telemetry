Class {
	#name : #VirtualMachineTelemetryProcessResumedEvent,
	#superclass : #VirtualMachineTelemetryEvent,
	#instVars : [
		'startSignal',
		'endSignal'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryProcessResumedEvent >> duration [
	^ self endTime - self startTime
]

{ #category : #accessing }
VirtualMachineTelemetryProcessResumedEvent >> endSignal [
	^ endSignal
]

{ #category : #accessing }
VirtualMachineTelemetryProcessResumedEvent >> endSignal: anObject [
	endSignal := anObject
]

{ #category : #accessing }
VirtualMachineTelemetryProcessResumedEvent >> endTime [
	^ endSignal timestamp
]

{ #category : #testing }
VirtualMachineTelemetryProcessResumedEvent >> isResumedEvent [
	^ true
]

{ #category : #accessing }
VirtualMachineTelemetryProcessResumedEvent >> startSignal [
	^ startSignal
]

{ #category : #accessing }
VirtualMachineTelemetryProcessResumedEvent >> startSignal: anObject [
	startSignal := anObject
]

{ #category : #accessing }
VirtualMachineTelemetryProcessResumedEvent >> startTime [
	^ startSignal timestamp
]
