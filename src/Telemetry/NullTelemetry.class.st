Class {
	#name : #NullTelemetry,
	#superclass : #Object,
	#traits : 'Telemetry',
	#classTraits : 'Telemetry classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Telemetry-Telemetries'
}

{ #category : #accessing }
NullTelemetry class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
NullTelemetry class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #comparing }
NullTelemetry >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
NullTelemetry >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self class hash
]

{ #category : #'api - telemetry' }
NullTelemetry >> time: aNameBlock during: aBlock [
	^ aBlock value
]
