Class {
	#name : #TelemetryPingWithTally,
	#superclass : #TelemetryPing,
	#instVars : [
		'tally'
	],
	#category : #'Telemetry-Utilities'
}

{ #category : #accessing }
TelemetryPingWithTally >> tally [
	^ tally
]

{ #category : #accessing }
TelemetryPingWithTally >> tally: anObject [
	self
		assert: [ anObject notNil ]
		description: [ 'Tally must not be nil' ].
	tally := anObject
]
