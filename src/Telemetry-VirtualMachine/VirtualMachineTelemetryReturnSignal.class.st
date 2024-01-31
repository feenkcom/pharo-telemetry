Class {
	#name : #VirtualMachineTelemetryReturnSignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'method',
		'sourceId',
		'executionLocation'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> accept: aVisitor [
	aVisitor visitReturn: self
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> executionLocationName [
	self isInterpreterCode
		ifTrue: [ ^ 'Interpreter' ].
	self isMachineCode
		ifTrue: [ ^ 'Machine' ].
	self isInterpreterToMachineCode
		ifTrue: [ ^ 'Interpreter -> Machine' ].
	self isMachineToInterpreterCode
		ifTrue: [ ^ 'Machine -> Interpreter' ].

	^ ''
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
	^ false
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isInterpreterCode [
	^ executionLocation = 1
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isInterpreterToMachineCode [
	^ executionLocation = 3
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isMachineCode [
	^ executionLocation = 2
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isMachineToInterpreterCode [
	^ executionLocation = 4
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isReturnSignal [
	^ true
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
		nextPutAll: 'to';
		space;
		print: self method
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> selector [
	^ method selector
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> sourceId [
	^ sourceId
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> sourceIdName [
	"
	ReturnToInterpreterSignal := 1.
	ReturnToExecutiveSignal := 2.
	ReturnToExecutivePostContextSwitchSignal := 3.
	ReturnToMachineCodeFrameSignal := 4.
	MaybeReturnToMachineCodeFrameSignal := 5.
	BaseFrameReturnSignal := 6
	"
	sourceId = 1
		ifTrue: [ ^ 'ReturnToInterpreterSignal' ].
		
	sourceId = 2
		ifTrue: [ ^ 'ReturnToExecutiveSignal' ].
		
	sourceId = 3
		ifTrue: [ ^ 'ReturnToExecutivePostContextSwitchSignal' ].
		
	sourceId = 4
		ifTrue: [ ^ 'ReturnToMachineCodeFrameSignal' ].
		
	sourceId = 5
		ifTrue: [ ^ 'MaybeReturnToMachineCodeFrameSignal' ].
		
	sourceId = 6
		ifTrue: [ ^ 'BaseFrameReturnSignal' ].
		
	sourceId = 7
		ifTrue: [ ^ 'ExternalAboutToReturnThroughSignal' ].

	^ 'unknown'
]
