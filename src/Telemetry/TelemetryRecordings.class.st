Class {
	#name : #TelemetryRecordings,
	#superclass : #LinkedList,
	#category : #'Telemetry-Utilities'
}

{ #category : #converting }
TelemetryRecordings >> asTelemetryPing [
	^ self size = 1
		ifTrue: [ self first ]
		ifFalse: [ TelemetryPing new
			name: 'Total';
			startTime: self first startTime;
			endTime: self last endTime;
			tasks: self copy ]
]

{ #category : #accessing }
TelemetryRecordings >> totalDuration [
	<return: #Duration>

	^ self
		ifEmpty: [ 0 seconds ]
		ifNotEmpty: [ self sum: [ :eachTask | eachTask duration ] ]
]
