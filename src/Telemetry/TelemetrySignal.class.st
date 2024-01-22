Class {
	#name : #TelemetrySignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'task',
		'telemetry'
	],
	#category : #'Telemetry-Logger'
}

{ #category : #accessing }
TelemetrySignal >> duration [
	^ self task duration
]

{ #category : #accessing }
TelemetrySignal >> ping [
	<return: #TelemetryPing>

	^ task
]

{ #category : #printing }
TelemetrySignal >> printOneLineContentsOn: stream [

	stream 
		print: task durationInMilliseconds;
		<< 'ms'
]

{ #category : #accessing }
TelemetrySignal >> signal [
	<objectGetter: #telemetrySignal>
	<return: #TelemetrySignal>

	^ self
]

{ #category : #accessing }
TelemetrySignal >> task [
	<return: #TelemetryPing>

	^ task
]

{ #category : #accessing }
TelemetrySignal >> task: aBlTelemetryTask [
	task := aBlTelemetryTask
]

{ #category : #accessing }
TelemetrySignal >> telemetry [
	^ telemetry
]

{ #category : #accessing }
TelemetrySignal >> telemetry: anObject [
	telemetry := anObject
]
