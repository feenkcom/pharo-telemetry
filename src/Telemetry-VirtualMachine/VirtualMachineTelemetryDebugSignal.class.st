Class {
	#name : #VirtualMachineTelemetryDebugSignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'message',
		'recordedClass',
		'recordedSelector'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryDebugSignal >> isDebugSignal [
	^ true
]

{ #category : #accessing }
VirtualMachineTelemetryDebugSignal >> message [
	^ message
]

{ #category : #accessing }
VirtualMachineTelemetryDebugSignal >> printOn: aStream [ 
	"Overrides method inherited from the byte arrayed collection."
	
	aStream
		nextPutAll: 'Debug'.
		
	self recordedClass
		ifNotNil: [ :aClass |
			aStream
				space;
				nextPutAll: 'recorded class';
				space;
				print: aClass.
			^ self ].
			
	self recordedSelector
		ifNotNil: [ :aSelector |
			aStream
				space;
				nextPutAll: 'recorded selector';
				space;
				print: aSelector.
			^ self ].

	aStream
		space;
		nextPutAll: self message asString
]

{ #category : #accessing }
VirtualMachineTelemetryDebugSignal >> recordedClass [
	"May be nil"
	^ recordedClass
		ifNotNil: [ :anObject |
			anObject isClass
				ifTrue: [ anObject ]
				ifFalse: [ anObject class ] ]
]

{ #category : #accessing }
VirtualMachineTelemetryDebugSignal >> recordedSelector [
	"May be nil"
	^ recordedClass
		ifNotNil: [ :anObject | anObject asSymbol ]
]
