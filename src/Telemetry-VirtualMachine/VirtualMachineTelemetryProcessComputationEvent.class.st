Class {
	#name : #VirtualMachineTelemetryProcessComputationEvent,
	#superclass : #VirtualMachineTelemetryEvent,
	#instVars : [
		'startSignal',
		'endSignal',
		'events'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessComputationEvent >> addEvent: aComputationEvent [
	events add: aComputationEvent
]

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
VirtualMachineTelemetryProcessComputationEvent >> events [
	^ events
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessComputationEvent >> gtDisplayOn: stream [
	super gtDisplayOn: stream.
	
	stream space.
	stream nextPut: $(.
	self value gtDisplayOn: stream.
	stream nextPut: $)
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessComputationEvent >> initialize [
	super initialize.
	
	events := OrderedCollection new: 0
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

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessComputationEvent >> value [
	^ endSignal value
]
