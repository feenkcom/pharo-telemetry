Class {
	#name : #BaseProcessTelemetry,
	#superclass : #ProcessLocalVariable,
	#traits : 'Telemetry',
	#classTraits : 'Telemetry classTrait',
	#category : #'Telemetry-Telemetries'
}

{ #category : #accessing }
BaseProcessTelemetry class >> defaultTelemetryClass [
	^ self subclassResponsibility
]

{ #category : #tasks }
BaseProcessTelemetry class >> emit [
	^ self soleInstance emit
]

{ #category : #testing }
BaseProcessTelemetry class >> isAbstract [
	^ self = BaseProcessTelemetry
]

{ #category : #tasks }
BaseProcessTelemetry class >> reset [
	^ self soleInstance reset
]

{ #category : #tasks }
BaseProcessTelemetry class >> time: aNameBlock during: aBlock [
	^ self soleInstance time: aNameBlock during: aBlock
]

{ #category : #tasks }
BaseProcessTelemetry class >> timeSync: aNameBlock during: aBlock [
	^ self soleInstance timeSync: aNameBlock during: aBlock
]

{ #category : #accessing }
BaseProcessTelemetry >> default [
	^ self class defaultTelemetryClass new
]

{ #category : #'api - telemetry' }
BaseProcessTelemetry >> emit [
	self value emit
]

{ #category : #accessing }
BaseProcessTelemetry >> ensureValue [
	^ self valueOrNil
		ifNil: [
			| aNewTelemetry |
			
			aNewTelemetry := self default.
			self value: aNewTelemetry.
			aNewTelemetry ]
]

{ #category : #'api - telemetry' }
BaseProcessTelemetry >> reset [	
	self value reset
]

{ #category : #'api - telemetry' }
BaseProcessTelemetry >> time: aNameBlock during: aBlock [
	^ self value time: aNameBlock during: aBlock
]
