Class {
	#name : #VirtualMachineTelemetrySendSignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'receiverClass',
		'executedMethod'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> accept: aVisitor [
	aVisitor visitSend: self
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> gtMessageSourceCodeFor: aView [
	<gtView>

	^ aView forward
		title: 'Message';
		priority: 3;
		object: [ executedMethod ];
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> method [
	^ executedMethod
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> methodClass [
	^ executedMethod methodClass
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> printOn: aStream [ 
	"Overrides method inherited from the byte arrayed collection."
	
	aStream
		nextPutAll: 'Send';
		space.
	
	(self receiverClass isNil or: [ self receiverClass = self methodClass])
		ifTrue: [ aStream print: self method ]
		ifFalse: [
			aStream
				print: self receiverClass;
				space;
				nextPut: $(;
				print: self methodClass;
				nextPut: $);
				space;
				nextPutAll: '>>';
				space;
				print: self selector ]
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> receiverClass [
	"May be nil"
	^ receiverClass
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> selector [
	^ executedMethod selector
]
