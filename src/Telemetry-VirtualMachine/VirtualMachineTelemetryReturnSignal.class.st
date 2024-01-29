Class {
	#name : #VirtualMachineTelemetryReturnSignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'method',
		'isFrom',
		'framePointer'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> accept: aVisitor [
	aVisitor visitReturn: self
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> framePointer [
	^ framePointer
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> gtSourceCodeFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Source';
		priority: 2;
		object: [ method ];
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> isFrom [
	^ isFrom
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> isTo [
	^ self isFrom not
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> method [
	^ method
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> methodClass [
	^ method methodClass
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> printOn: aStream [ 
	"Overrides method inherited from the byte arrayed collection."
	
	aStream
		nextPutAll: 'Return';
		space;
		nextPutAll: (self isFrom ifTrue: [ 'from' ] ifFalse: [ 'to' ]);
		space;
		print: self method;
		space;
		print: self framePointer.
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> selector [
	^ method selector
]
