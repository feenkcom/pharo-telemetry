Class {
	#name : #VirtualMachineTelemetrySendSignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'methodClass',
		'selector',
		'sender',
		'framePointer'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> accept: aVisitor [
	aVisitor visitSend: self
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> framePointer [
	^ framePointer
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> gtMessageSourceCodeFor: aView [
	<gtView>

	^ aView forward
		title: 'Message';
		priority: 3;
		object: [ methodClass lookupSelector: selector ];
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> gtSenderSourceCodeFor: aView [
	<gtView>

	^ aView forward
		title: 'Sender';
		priority: 2;
		object: [ sender ];
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> methodClass [
	^ methodClass
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> printOn: aStream [ 
	"Overrides method inherited from the byte arrayed collection."
	
	aStream
		nextPutAll: 'Send';
		space;
		print: self methodClass;
		nextPutAll: '>>'; print: self selector;
		space;
		nextPutAll: 'from';
		space;
		print: self sender;
		space;
		print: self framePointer.
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> selector [
	^ selector
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> sender [
	^ sender
]
