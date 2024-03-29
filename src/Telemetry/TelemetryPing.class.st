Class {
	#name : #TelemetryPing,
	#superclass : #Object,
	#instVars : [
		'startTime',
		'endTime',
		'realStartTime',
		'realEndTime',
		'gcStartTime',
		'gcEndTime',
		'name',
		'recordings',
		'sender'
	],
	#category : #'Telemetry-Utilities'
}

{ #category : #adding }
TelemetryPing >> addPing: aTelemetryPing [
	recordings add: aTelemetryPing
]

{ #category : #accessing }
TelemetryPing >> childrenOverhead [
	^ self tasks
		inject: 0
		into: [ :aSum :eachTask | aSum + eachTask totalOverhead ]
]

{ #category : #accessing }
TelemetryPing >> copyWithTally: aTally [
	^ TelemetryPingWithTally new
		copySameFrom: self;
		tally: aTally;
		yourself
]

{ #category : #accessing }
TelemetryPing >> duration [
	"The duration of the ping in microseconds"
	<return: #Number>

	^ self endTime - self startTime - self childrenOverhead - self gcDurationInMicroseconds
]

{ #category : #printing }
TelemetryPing >> durationInMicroseconds [
	"Answer the receiver's duration.
	If it hasn't been run, answer -1mS"

	(endTime isNil or: [ startTime isNil ]) ifTrue: [ ^ -1 ].
	^ self duration
]

{ #category : #printing }
TelemetryPing >> durationInMilliseconds [
	"Answer the receiver's duration.
	If it hasn't been run, answer -1mS"

	(endTime isNil or: [ startTime isNil ]) ifTrue: [ ^ -1 ].
	^ self duration / 1000.0
]

{ #category : #accessing }
TelemetryPing >> endTime [
	^ endTime
]

{ #category : #accessing }
TelemetryPing >> endTime: aNumberOfMicroseconds [
	endTime := aNumberOfMicroseconds
]

{ #category : #accessing }
TelemetryPing >> gcDurationInMicroseconds [
	^ (self gcEndTime - self gcStartTime)
]

{ #category : #accessing }
TelemetryPing >> gcDurationInMilliseconds [
	^ self gcDurationInMicroseconds / 1000.0
]

{ #category : #accessing }
TelemetryPing >> gcEndTime [
	^ gcEndTime
]

{ #category : #accessing }
TelemetryPing >> gcStartTime [
	^ gcStartTime
]

{ #category : #initialization }
TelemetryPing >> initialize [
	super initialize.
	
	name := ''.
	recordings := TelemetryRecordings new
]

{ #category : #accessing }
TelemetryPing >> name [
	^ name
]

{ #category : #accessing }
TelemetryPing >> name: anObject [
	name := anObject
]

{ #category : #accessing }
TelemetryPing >> overhead [
	^ (self realEndTime - self realStartTime) - (self endTime - self startTime)
]

{ #category : #printing }
TelemetryPing >> printDurationInMilliseconds [
	^ self durationInMilliseconds asString, 'ms'
]

{ #category : #printing }
TelemetryPing >> printOn: aStream [
	aStream
		nextPutAll: self name; space;
		nextPut: $(;
		nextPutAll: self printDurationInMilliseconds;
		nextPut: $)
]

{ #category : #accessing }
TelemetryPing >> realEndTime [
	^ realEndTime
]

{ #category : #accessing }
TelemetryPing >> realEndTime: aNumberOfMicroseconds [
	realEndTime := aNumberOfMicroseconds
]

{ #category : #accessing }
TelemetryPing >> realStartTime [
	^ realStartTime
]

{ #category : #accessing }
TelemetryPing >> realStartTime: aNumberOfMicroseconds [
	realStartTime := aNumberOfMicroseconds
]

{ #category : #accessing }
TelemetryPing >> recordOverheadEndTime [
	gcEndTime := self totalGCTimeMicroseconds
]

{ #category : #accessing }
TelemetryPing >> recordOverheadStartTime [
	gcStartTime := self totalGCTimeMicroseconds
]

{ #category : #accessing }
TelemetryPing >> sender [

	^ sender
]

{ #category : #accessing }
TelemetryPing >> sender: anObject [

	sender := anObject
]

{ #category : #accessing }
TelemetryPing >> startTime [
	^ startTime
]

{ #category : #accessing }
TelemetryPing >> startTime: aNumberOfMicroseconds [
	startTime := aNumberOfMicroseconds
]

{ #category : #accessing }
TelemetryPing >> tasks [
	^ recordings
]

{ #category : #accessing }
TelemetryPing >> tasks: aCollectionOfTasks [
	recordings := aCollectionOfTasks as: TelemetryRecordings
]

{ #category : #'private - primitives' }
TelemetryPing >> totalFullGCTimeMicroseconds [
	"Answer the total time in microseconds spent in full GCs since startup (read-only)."
	<primitive: #'primitiveFullGarbageCollectorMicroseconds'>

	^ Smalltalk vm totalFullGCTime * 1000
]

{ #category : #'private - primitives' }
TelemetryPing >> totalGCTimeMicroseconds [
	^ self totalFullGCTimeMicroseconds + self totalScavengeGCTimeMicroseconds
]

{ #category : #accessing }
TelemetryPing >> totalOverhead [
	^ self overhead + self childrenOverhead
]

{ #category : #'private - primitives' }
TelemetryPing >> totalScavengeGCTimeMicroseconds [
	"Answer the total time in microseconds spent in scavenge GCs since startup (read-only)."
	<primitive: #'primitiveScavengeGarbageCollectorMicroseconds'>

	^ Smalltalk vm totalIncrementalGCTime * 1000
]
