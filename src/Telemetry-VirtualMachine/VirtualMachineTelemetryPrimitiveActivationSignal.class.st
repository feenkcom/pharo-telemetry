Class {
	#name : #VirtualMachineTelemetryPrimitiveActivationSignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'signalId'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryPrimitiveActivationSignal >> accept: aVisitor [
	aVisitor visitPrimitiveActivation: self
]

{ #category : #accessing }
VirtualMachineTelemetryPrimitiveActivationSignal >> isActivation [
	^ signalId = 1
]

{ #category : #accessing }
VirtualMachineTelemetryPrimitiveActivationSignal >> isDeactivation [
	^ signalId = 0
]

{ #category : #accessing }
VirtualMachineTelemetryPrimitiveActivationSignal >> mayCallMethods [
	^ signalId = 2
]

{ #category : #accessing }
VirtualMachineTelemetryPrimitiveActivationSignal >> printOn: aStream [ 
	"Overrides method inherited from the byte arrayed collection."
	
	aStream
		nextPutAll: 'Primitive'
]

{ #category : #accessing }
VirtualMachineTelemetryPrimitiveActivationSignal >> sourceIdName [
	signalId = 0
		ifTrue: [ ^ 'Deactivation' ].

	signalId = 1
		ifTrue: [ ^ 'Activation' ].

	signalId = 2
		ifTrue: [ ^ 'MayCallMethods' ].

	^ 'Unknown: ', signalId asString
]
