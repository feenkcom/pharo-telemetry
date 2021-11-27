Class {
	#name : #ProcessTelemetry,
	#superclass : #BaseProcessTelemetry,
	#classInstVars : [
		'DefaultTelemetryClass'
	],
	#category : #'Telemetry-Telemetries'
}

{ #category : #accessing }
ProcessTelemetry class >> defaultTelemetryClass [
	^ DefaultTelemetryClass ifNil: [ NullTelemetry ]
]

{ #category : #accessing }
ProcessTelemetry class >> defaultTelemetryClass: aClass [
	DefaultTelemetryClass := aClass.
	
	self allInstancesDo: [ :eachProcessTelemetry |
		Process allSubInstancesDo: [ :eachProcess |
			eachProcess
				psValueAt: eachProcessTelemetry index
				put: nil ] ]
]

{ #category : #tasks }
ProcessTelemetry class >> rootTimeSync: aNameBlock during: aBlock [
	^ self soleInstance rootTimeSync: aNameBlock during: aBlock
]

{ #category : #accessing }
ProcessTelemetry >> rootTimeSync: aNameBlock during: aBlock [
	| aTelemetry aResult |
	"we store the telemetry on a stack to prevent it from being garbage collected"
	aTelemetry := self ensureValue.

	self value: aTelemetry.
	self reset.

	aResult := self
		time: aNameBlock
		during: aBlock.

	self emit.

	^ aResult
]
