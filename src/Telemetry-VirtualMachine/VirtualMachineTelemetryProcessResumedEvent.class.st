Class {
	#name : #VirtualMachineTelemetryProcessResumedEvent,
	#superclass : #VirtualMachineTelemetryEvent,
	#instVars : [
		'startSignal',
		'endSignal',
		'events'
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

{ #category : #accessing }
VirtualMachineTelemetryProcessResumedEvent >> events [
	^ events
]

{ #category : #accessing }
VirtualMachineTelemetryProcessResumedEvent >> events: anObject [
	events := anObject
]

{ #category : #views }
VirtualMachineTelemetryProcessResumedEvent >> gtEventsFor: aView [
	<gtView>
	events ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Signals';
		priority: 7;
		items: [ events ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each payload gtDisplayString ]
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryProcessResumedEvent >> gtStackFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Stack';
		object: [ endSignal ];
		priority: 5;
		view: #gtStackFor:
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
