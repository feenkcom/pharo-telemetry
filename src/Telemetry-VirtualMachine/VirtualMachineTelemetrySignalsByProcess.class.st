Class {
	#name : #VirtualMachineTelemetrySignalsByProcess,
	#superclass : #Object,
	#instVars : [
		'process',
		'signals',
		'startTime',
		'endTime'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineTelemetrySignalsByProcess >> endTime [
	^ endTime
]

{ #category : #accessing }
VirtualMachineTelemetrySignalsByProcess >> process [
	^ process
]

{ #category : #accessing }
VirtualMachineTelemetrySignalsByProcess >> process: anObject [
	process := anObject
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetrySignalsByProcess >> signals [
	^ signals
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetrySignalsByProcess >> signals: aCollectionOfSignals [
	signals := aCollectionOfSignals.
	startTime := signals
		inject: signals first startTime
		into: [ :anEndTime :each | anEndTime min: each startTime ].
	endTime := signals
		inject: signals first endTime
		into: [ :anEndTime :each | anEndTime max: each endTime ].
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetrySignalsByProcess >> startTime [
	^ startTime
]
