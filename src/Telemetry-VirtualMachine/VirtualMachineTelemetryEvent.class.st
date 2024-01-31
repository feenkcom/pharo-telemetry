Class {
	#name : #VirtualMachineTelemetryEvent,
	#superclass : #Object,
	#instVars : [
		'events',
		'startSignal',
		'endSignal',
		'duration'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryEvent >> addEvent: anEvent [
	"events ifNotEmpty: [ :theEvents |
		self assert: theEvents first method method == anEvent method method ]."

	events add: anEvent
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> durationMicroseconds [
	^ duration / 1000.0
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> durationMilliseconds [
	^ duration / 1000000.0
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> durationNanos [
	^ duration
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> endSignal [
	^ endSignal
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> endSignal: aSignal [
	self
		assert: [ endSignal isNil ]
		description: [ 'End can''t be re-assigned' ].
	endSignal := aSignal.
	duration := endSignal timestamp - startSignal timestamp
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> events [
	^ events
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> framePointer [
	^ startSignal framePointer
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> gtEventsTreeFor: aView [
	<gtView>
	
	^ aView tree
		title: 'Events';
		priority: 2;
		items: [ { self } ];
		children: #events;
		itemText: [ :each |
			each hasEnd
				ifTrue: [ each printString asRopedText ]
				ifFalse: [ each printString asRopedText foreground: BrGlamorousColors failureBorderColor ] ];
		expandUpTo: 10;
		actionUpdateButton
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> gtSenderSourceCodeFor: aView [
	<gtView>

	^ aView forward
		title: 'Message';
		priority: 3;
		object: [ startSignal ];
		view: #gtMessageSourceCodeFor:
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> hasEnd [
	^ endSignal isNotNil
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> initialize [
	super initialize.
	
	events := OrderedCollection new.
	duration := 0
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> method [
	^ startSignal method
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> methodClass [
	^ startSignal methodClass
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> printOn: aStream [
	startSignal ifNil: [ ^ super printOn: aStream ].
	startSignal printMethodOn: aStream.
	aStream
		space;
		nextPut: $(;
		print: self durationMicroseconds;
		space;
		nextPutAll: 'μs';
		nextPut: $)
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> selector [
	^ startSignal selector
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> sender [
	^ startSignal sender
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> startSignal [
	^ startSignal
]

{ #category : #accessing }
VirtualMachineTelemetryEvent >> startSignal: aSignal [
	self
		assert: [ startSignal isNil ]
		description: [ 'Start can''t be re-assigned' ].
	startSignal := aSignal
]
