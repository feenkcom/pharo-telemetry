Class {
	#name : #VirtualMachineTelemetryEventGenerator,
	#superclass : #Object,
	#instVars : [
		'eventStack',
		'signalStack',
		'rootEvents'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> generateFrom: theSignals [
	theSignals withIndexDo: [ :each :i | i = 53 ifTrue: [ "self halt" ]. each accept: self ].
	rootEvents size >= 1
		ifTrue: [ ^ rootEvents first ].
	^ rootEvents
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> initialize [
	super initialize.

	eventStack := Stack new.
	signalStack := Stack new.
	rootEvents := OrderedCollection new
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> isEvent: anEvent targetForReturnTo: aSignal comparingByFramePointer: shouldCompareByFramePointer [
	shouldCompareByFramePointer
		ifTrue: [ ^ anEvent framePointer = aSignal framePointer ].

	^ true
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> newEvent [
	^ VirtualMachineTelemetryEvent new
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> pushNewEventFor: aSignal [
	| anEvent |
	anEvent := self newEvent.
	anEvent startSignal: aSignal.

	eventStack
		ifEmpty: [
			eventStack push: anEvent.
			rootEvents add: anEvent ]
		ifNotEmpty: [
			eventStack top addEvent: anEvent.
			eventStack push: anEvent ]
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitContextSwitch: aSignal [
	self halt.
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitMethodSwitch: aSignal [
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitReturn: aSignal [
	| currentEvent |
	
	true ifTrue: [ ^ self ].
	
	eventStack ifEmpty: [ ^ self ].

	(eventStack anySatisfy: [ :each | each framePointer = aSignal framePointer ])
		ifTrue: [ ^ self visitReturnBackToFrame: aSignal ].
	
	true ifTrue: [ ^ eventStack pop endSignal: aSignal ].
	
	[ currentEvent := eventStack pop.
	  currentEvent endSignal: aSignal ]
		doWhileTrue: [
			(currentEvent framePointer ~= aSignal framePointer)
				and: [ eventStack notEmpty ] ]
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitReturnBackToFrame: aSignal [
	| currentEvent |
	
	[ currentEvent := eventStack pop.
	  currentEvent endSignal: aSignal ]
		doWhileTrue: [
			(currentEvent framePointer ~= aSignal framePointer)
				and: [ eventStack notEmpty ] ]
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitSend: aSignal [
	eventStack ifNotEmpty: [ :aStack |
		(eventStack anySatisfy: [ :each | each framePointer = aSignal framePointer ])
			ifTrue: [ self visitReturnBackToFrame: aSignal ] ].
			
	self pushNewEventFor: aSignal
]
