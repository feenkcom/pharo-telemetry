Class {
	#name : #VirtualMachineTelemetrySendSignal,
	#superclass : #VirtualMachineTelemetryFrameSignal,
	#instVars : [
		'receiverClass',
		'executedMethod',
		'sourceId'
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
		object: [ self method ];
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> method [
	^ self receiverClass
		ifNotNil: [ :aClass | aClass lookupSelector: self selector ]
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> methodClass [
	^ self method methodClass
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> printMethodOn: aStream [
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
VirtualMachineTelemetrySendSignal >> printOn: aStream [ 
	"Overrides method inherited from the byte arrayed collection."

	aStream
		nextPutAll: 'Send';
		space.

	self printMethodOn: aStream
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> receiverClass [
	"May be nil"
	^ receiverClass
		ifNotNil: [ :anObject |
			anObject isClass
				ifTrue: [ anObject ]
				ifFalse: [ anObject class ] ]
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> selector [
	^ executedMethod asSymbol
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> sourceId [
	^ sourceId
]

{ #category : #accessing }
VirtualMachineTelemetrySendSignal >> sourceIdName [
	sourceId = 1
		ifTrue: [ ^ 'EmitLinkedSend' ].
		
	sourceId = 2
		ifTrue: [ ^ 'ceSendFromInLineCacheMiss' ].
		
	sourceId = 3
		ifTrue: [ ^ 'ceInterpretMethodFromPIC' ].
		
	sourceId = 4
		ifTrue: [ ^ 'sendBreakpoint' ].

	sourceId = 5
		ifTrue: [ ^ 'commonSendOrdinary' ].

	sourceId = 6
		ifTrue: [ ^ 'ceSend:above:to:numArgs:' ].
	
	sourceId = 7
		ifTrue: [ ^ 'ceSend:super:to:numArgs:' ].

	sourceId = 8
		ifTrue: [ ^ 'interpretMethodFromMachineCode' ].
		
	sourceId = 9
		ifTrue: [ ^ 'executeNewMethod' ].
		
	sourceId = 10
		ifTrue: [ ^ 'activateNewMethod' ].
		
	sourceId = 11
		ifTrue: [ ^ 'activateCoggedNewMethod:' ].
		
	sourceId = 12
		ifTrue: [ ^ 'returnToExecutive:postContextSwitch: (Interpr)' ].
		
	sourceId = 13
		ifTrue: [ ^ 'returnToExecutive:postContextSwitch: (Machine)' ].

	^ 'Unknown: ',sourceId asString
]
