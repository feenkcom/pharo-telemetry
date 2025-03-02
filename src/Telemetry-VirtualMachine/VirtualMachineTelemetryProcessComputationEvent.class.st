Class {
	#name : #VirtualMachineTelemetryProcessComputationEvent,
	#superclass : #VirtualMachineTelemetryEvent,
	#instVars : [
		'startSignal',
		'endSignal'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryProcessComputationEvent >> duration [
	^ self endTime - self startTime
]

{ #category : #accessing }
VirtualMachineTelemetryProcessComputationEvent >> endSignal [
	^ endSignal
]

{ #category : #accessing }
VirtualMachineTelemetryProcessComputationEvent >> endSignal: anObject [
	endSignal := anObject
]

{ #category : #accessing }
VirtualMachineTelemetryProcessComputationEvent >> endTime [
	^ endSignal timestamp
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessComputationEvent >> isComputationEvent [
	^ true
]

{ #category : #accessing }
VirtualMachineTelemetryProcessComputationEvent >> startSignal [
	^ startSignal
]

{ #category : #accessing }
VirtualMachineTelemetryProcessComputationEvent >> startSignal: anObject [
	startSignal := anObject
]

{ #category : #accessing }
VirtualMachineTelemetryProcessComputationEvent >> startTime [
	^ startSignal timestamp
]
