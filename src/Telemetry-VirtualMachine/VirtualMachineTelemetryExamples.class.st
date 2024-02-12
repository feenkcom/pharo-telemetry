Class {
	#name : #VirtualMachineTelemetryExamples,
	#superclass : #Object,
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryExamples >> blockValueValue [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ [ :a :b | a + b ] value: 10 value: 20 ].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 1.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> eventsOn: aBlock [
	^ (self generateEventsFrom: (VirtualMachineTelemetry spyOn: aBlock))
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> generateEventsFrom: aTelemetry [
	^ VirtualMachineTelemetrySimpleEventGenerator new generateFrom: aTelemetry signals
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> objectCopy [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ Object new copy].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 2.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> objectHash [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ Object new hash].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 2.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> objectIdentityHash [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ Object new identityHash].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 2.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> objectNew [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ Object new].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 1.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> objectPointNew [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ 100@200 ].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 1.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> objectShallowCopy [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ Object new shallowCopy].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 2.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> pointCopy [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ (200@100) copy].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 2.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> pointInfinity [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ (Float infinity @ Float infinity) isZero ].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 4.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> pointIsZero [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ (0@100) isZero ].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 2.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> smallIntegerIdentityHash [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ 42 identityHash].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 1.
	
	^ aRootEvent
]

{ #category : #accessing }
VirtualMachineTelemetryExamples >> stringNew [
	<gtExample>
	| aRootEvent |
	
	aRootEvent := self eventsOn: [ String new].
	self assert: aRootEvent hasEnd.
	self assert: aRootEvent events size equals: 1.
	
	^ aRootEvent
]
