Class {
	#name : #TelemetryLogger,
	#superclass : #MemoryLogger,
	#instVars : [
		'telemetryClass'
	],
	#category : #'Telemetry-Logger'
}

{ #category : #initialize }
TelemetryLogger >> initialize [
	super initialize.
	
	telemetryClass := MemoryTelemetry
]

{ #category : #accessing }
TelemetryLogger >> nextPut: aSignal [
	(aSignal class == TelemetrySignal
		and: [ aSignal telemetry class == self telemetryClass ])
			ifFalse: [ ^ self ].

	super nextPut: aSignal
]

{ #category : #registering }
TelemetryLogger >> start [
	super start.
	
	self announcer announce: TelemetryLoggerStarted new
]

{ #category : #registering }
TelemetryLogger >> stop [
	super stop.
	
	self announcer announce: TelemetryLoggerStopped new
]

{ #category : #accessing }
TelemetryLogger >> telemetryClass [
	^ telemetryClass
]

{ #category : #accessing }
TelemetryLogger >> telemetryClass: anObject [
	telemetryClass := anObject
]

{ #category : #accessing }
TelemetryLogger >> totalDuration [
	^ recordings
		inject: 0 milliSeconds
		into: [ :total :each | total + each totalDuration ]
]

{ #category : #'announcer - subscription' }
TelemetryLogger >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
