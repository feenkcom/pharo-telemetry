Class {
	#name : #VirtualMachineTelemetrySimpleEventGenerator,
	#superclass : #Object,
	#instVars : [
		'eventStack',
		'rootEvents',
		'blockReturnCounter'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetrySimpleEventGenerator >> generateFrom: theSignals [
	theSignals withIndexDo: [ :each :i | i = 53 ifTrue: [ "self halt" ]. each accept: self ].
	rootEvents size >= 1
		ifTrue: [ ^ rootEvents first events first ].
	^ rootEvents
]

{ #category : #accessing }
VirtualMachineTelemetrySimpleEventGenerator >> initialize [
	super initialize.

	eventStack := Stack new.
	rootEvents := OrderedCollection new.
	blockReturnCounter := 0
]

{ #category : #accessing }
VirtualMachineTelemetrySimpleEventGenerator >> newEvent [
	^ VirtualMachineTelemetryEvent new
]

{ #category : #accessing }
VirtualMachineTelemetrySimpleEventGenerator >> pushNewEventFor: aSignal [
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
VirtualMachineTelemetrySimpleEventGenerator >> visitContextSwitch: aSignal [
	
]

{ #category : #accessing }
VirtualMachineTelemetrySimpleEventGenerator >> visitReturn: aSignal [	
	| currentEvent |
	
	"aSignal isReturnToExecutiveInInterpreter
		ifTrue: [ ^ self ]."

	"aSignal isReturnToMachineCodeFrame
		ifTrue: [ ^ self ]."
		
	aSignal isArrowReturnTrampolineInInterpreter
		ifTrue: [ ^ self ].

	aSignal sourceId = 41
		ifTrue: [ blockReturnCounter := blockReturnCounter + 1 ]
		ifFalse: [ blockReturnCounter := 0 ].
		
	blockReturnCounter = 1
		ifTrue: [ ^ self ].
	
	"(aSignal isMaybeReturnToMachineCodeFrame
		or: [ aSignal isReturnToMachineCodeFrame ])
			ifTrue: [ ^ self visitReturnBackToFrame: aSignal ]."
	
	eventStack ifEmpty: [ ^ self ].
	currentEvent := eventStack pop.
	currentEvent endSignal: aSignal
]

{ #category : #accessing }
VirtualMachineTelemetrySimpleEventGenerator >> visitReturnBackToFrame: aSignal [
	| currentEvent |
	
	eventStack ifEmpty: [ ^ self ].
	
	(eventStack anySatisfy: [ :each | each framePointer = aSignal framePointer ])
		ifFalse: [
			currentEvent := eventStack pop.
	  		currentEvent endSignal: aSignal.
	  		^ self ].
	
	[ currentEvent := eventStack pop.
	  currentEvent endSignal: aSignal ]
		doWhileTrue: [
			(currentEvent framePointer ~= aSignal framePointer)
				and: [ eventStack notEmpty ] ]
]

{ #category : #accessing }
VirtualMachineTelemetrySimpleEventGenerator >> visitSend: aSignal [
	aSignal sourceId = 16
		ifTrue: [ ^ self ].
		
	self pushNewEventFor: aSignal
]
