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
	| aScale |
	self hasEnd
		ifTrue: [ aScale := NSScale linear.
			aScale
				range: {Color gray.
						Color
							r: 216
							g: 55
							b: 62
							range: 255}.
			aScale
				domain: {0.
						self durationMicroseconds} ].

	^ aView columnedTree
		title: 'Events';
		priority: 2;
		items: [ {self} ];
		children: #events;
		column: 'Method'
			text: [ :each | 
				each hasEnd
					ifTrue: [
						| eachColor |
						eachColor := self hasEnd
							ifTrue: [ aScale scale: each durationMicroseconds ]
							ifFalse: [ Color black ].
						each printString asRopedText foreground: eachColor ]
					ifFalse: [ each printString asRopedText
							foreground: BrGlamorousColors failureBorderColor ] ];
		column: 'Percent'
			text: [ :each | 
				self hasEnd
					ifTrue: [ ((each durationMicroseconds / self durationMicroseconds asFloat * 100
							printShowingDecimalPlaces: 1) , '%') asRopedText glamorousRegularFont
							foreground: (aScale scale: each durationMicroseconds) ]
					ifFalse: [ '-' ] ]
			width: 100;
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
	^ endSignal notNil
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
