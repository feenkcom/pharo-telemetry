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
	theSignals withIndexDo: [ :each :i | i = 31 ifTrue: [ "self halt" ]. each accept: self ].
	rootEvents size = 1
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
VirtualMachineTelemetryEventGenerator >> isEvent: anEvent targetForReturnFrom: aSignal comparingByFramePointer: shouldCompareByFramePointer [
	shouldCompareByFramePointer
		ifTrue: [ ^ anEvent framePointer = aSignal framePointer ].
	
	"different selector => not our candidate"
	anEvent selector ~= aSignal selector
		ifTrue: [ ^ false ].

	anEvent methodClass = aSignal methodClass
		ifTrue: [ ^ true ].
	
	^ true "anEvent methodClass lookupSelector: aSignal selector"
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> isEvent: anEvent targetForReturnTo: aSignal comparingByFramePointer: shouldCompareByFramePointer [
	shouldCompareByFramePointer
		ifTrue: [ ^ anEvent framePointer = aSignal framePointer ].

	^ anEvent sender = aSignal method
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
VirtualMachineTelemetryEventGenerator >> pushSiblingEventFor: aSignal [
	eventStack ifNotEmpty: [ eventStack pop ].
	self pushNewEventFor: aSignal.
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitContextSwitch: aSignal [
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitMethodSwitch: aSignal [
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitReturn: aSignal [
	signalStack ifEmpty: [ ^ self ].
	eventStack ifEmpty: [ ^ self ].

	aSignal isTo
		ifTrue: [ self visitReturnToFrame: aSignal ]
		ifFalse: [ self visitReturnFromFrame: aSignal ]
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitReturnFromFrame: aSignal [
	| hasTargetFramePointer currentEvent |
	
	hasTargetFramePointer := eventStack anySatisfy: [ :each | each framePointer = aSignal framePointer ].
	hasTargetFramePointer ifTrue: [ ^ self visitReturnFromSpecificFrame: aSignal ].

	[
		currentEvent := eventStack pop.
		currentEvent endSignal: aSignal.
		signalStack pop ]
	doWhileFalse: [
		(self isEvent: currentEvent targetForReturnFrom: aSignal comparingByFramePointer: hasTargetFramePointer)
			or: [ eventStack isEmpty or: [ signalStack isEmpty ] ] ]
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitReturnFromSpecificFrame: aSignal [
	"The return signal's frame pointer corresponds to one of the frames on the events stack"
	| currentEvent |

	"keep popping until the popped event matches the frame pointer.
	then we should pop one more time to get back"
	[
		currentEvent := eventStack pop.
		currentEvent endSignal: aSignal.
		signalStack pop ]
	doWhileFalse: [
		(currentEvent framePointer = aSignal framePointer)
			or: [ eventStack isEmpty or: [ signalStack isEmpty ] ] ].
			
	eventStack ifNotEmpty: [
		currentEvent := eventStack pop.
		currentEvent endSignal: aSignal ].
		
	signalStack ifNotEmpty: [ signalStack pop ]
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitReturnToFrame: aSignal [
	| hasTargetFramePointer currentEvent |
	
	hasTargetFramePointer := eventStack anySatisfy: [ :each | each framePointer = aSignal framePointer ].

	[
		currentEvent := eventStack pop.
		currentEvent endSignal: aSignal.
		signalStack pop ]
	doWhileFalse: [
		(self isEvent: currentEvent targetForReturnTo: aSignal comparingByFramePointer: hasTargetFramePointer)
			or: [ eventStack isEmpty or: [ signalStack isEmpty ] ] ]
]

{ #category : #accessing }
VirtualMachineTelemetryEventGenerator >> visitSend: aSignal [
	signalStack
		ifEmpty: [
			self pushNewEventFor: aSignal.
			signalStack push: aSignal.
			^ self ].

	"message sends on the same frame"
	signalStack top framePointer = aSignal framePointer
		ifTrue: [
			self pushSiblingEventFor: aSignal.
		
			eventStack top addSignal: aSignal.
			signalStack pop.
			signalStack push: aSignal.
			^ self ].

	"message send on a different frame"
	self pushNewEventFor: aSignal.
	signalStack push: aSignal.
]
