Class {
	#name : #VirtualMachineTelemetryReturnSignal,
	#superclass : #VirtualMachineTelemetryFrameSignal,
	#instVars : [
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

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isArrowReturnTrampolineInInterpreter [
	^ self isInterpreterCode and: [ sourceId = 21 ]
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isBaseFrame [
	^ sourceId = 6
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isCommonCallerReturn [
	^ sourceId = 10
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
VirtualMachineTelemetryReturnSignal >> isMaybeReturnToMachineCodeFrame [
	^ sourceId = 4
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isPostContextSwitch [
	^ sourceId = 7 or: [ sourceId = 8 ]
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> isPrimReturn [
	^ sourceId = 25
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isReturnSignal [
	^ true
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isReturnToExecutiveInInterpreter [
	^ self isInterpreterCode and: [ sourceId = 31 ]
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isReturnToInterpreter [
	^ sourceId = 1
]

{ #category : #testing }
VirtualMachineTelemetryReturnSignal >> isReturnToMachineCodeFrame [
	^ sourceId = 3
]

{ #category : #accessing }
VirtualMachineTelemetryReturnSignal >> printOn: aStream [ 
	"Overrides method inherited from the byte arrayed collection."
	
	aStream nextPutAll: 'Return'
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
	ReturnToMachineCodeFrameSignal := 3.
	MaybeReturnToMachineCodeFrameSignal := 4.
	ExternalAboutToReturnThroughSignal := 5.
	BaseFrameReturnSignal := 6.
	ReturnToExecutivePostContextWithSwitchSignal := 7.
	ReturnToExecutivePostContextWithoutSwitchSignal := 8.
	NonLocalReturnSignal := 9.
	CommonCallerReturnSignal := 10.
	SlowPrimitiveReturnSignal := 11.
	
	ArrowReturnTrampolineSignal := 21.
	BlockReturnTrampolineSignal := 22.
	EnilopmartReturnTrampolineSignal := 23.
	QuickPrimitiveReturnTrampolineSignal := 24.
	PrimReturnTrampolineSignal := 25.
	
	ReturnToExecutiveInInterpreterSignal := 31.
	ReturnToExecutiveInMachineCodeSignal := 32.
	"
	sourceId = 1
		ifTrue: [ ^ 'ReturnToInterpreterSignal' ].
		
	sourceId = 2
		ifTrue: [ ^ 'ReturnToExecutiveSignal' ].
		
	sourceId = 3
		ifTrue: [ ^ 'ReturnToMachineCodeFrameSignal' ].
		
	sourceId = 4
		ifTrue: [ ^ 'MaybeReturnToMachineCodeFrameSignal' ].
		
	sourceId = 5
		ifTrue: [ ^ 'ExternalAboutToReturnThroughSignal' ].
		
	sourceId = 6
		ifTrue: [ ^ 'BaseFrameReturnSignal' ].
		
	sourceId = 7
		ifTrue: [ ^ 'ReturnToExecutivePostContextWithSwitchSignal' ].
		
	sourceId = 8
		ifTrue: [ ^ 'ReturnToExecutivePostContextWithoutSwitchSignal' ].
	
	sourceId = 9
		ifTrue: [ ^ 'NonLocalReturnSignal' ].
		
	sourceId = 10
		ifTrue: [ ^ 'CommonCallerReturnSignal' ].
		
	sourceId = 11
		ifTrue: [ ^ 'SlowPrimitiveReturnSignal' ].
		
	sourceId = 21
		ifTrue: [ ^ 'ArrowReturnTrampolineSignal' ].
		
	sourceId = 22
		ifTrue: [ ^ 'BlockReturnTrampolineSignal' ].
	
	sourceId = 23
		ifTrue: [ ^ 'EnilopmartReturnTrampolineSignal' ].
		
	sourceId = 24
		ifTrue: [ ^ 'QuickPrimitiveReturnTrampolineSignal' ].

	sourceId = 25
		ifTrue: [ ^ 'PrimReturnTrampolineSignal' ].
		
	sourceId = 31
		ifTrue: [ ^ 'ReturnToExecutiveInInterpreterSignal' ].

	sourceId = 32
		ifTrue: [ ^ 'ReturnToExecutiveInMachineCodeSignal' ].

	^ 'Unknown: ',sourceId asString
]
