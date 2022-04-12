Class {
	#name : #MemoryTelemetry,
	#superclass : #Object,
	#traits : 'Telemetry',
	#classTraits : 'Telemetry classTrait',
	#instVars : [
		'recordings',
		'pingsStack'
	],
	#category : #'Telemetry-Telemetries'
}

{ #category : #'api - telemetry' }
MemoryTelemetry >> emitAs: aSourceTelemetry [
	recordings ifNotEmpty: [ :theTasks |
		(TelemetrySignal new
			task: recordings asTelemetryPing;
			telemetry: aSourceTelemetry) emit ].
	self reset
]

{ #category : #'private - lifecycle' }
MemoryTelemetry >> finishSync [
	| anEndTime |

	anEndTime := Time microsecondClockValue.

	pingsStack
		ifEmpty: [ ^ self ].
	
	pingsStack pop
		realEndTime: Time microsecondClockValue;
		endTime: anEndTime;
		recordOverheadEndTime
]

{ #category : #initialization }
MemoryTelemetry >> initialize [
	super initialize.
	
	recordings := TelemetryRecordings new.
	pingsStack := Stack new
]

{ #category : #'api - telemetry' }
MemoryTelemetry >> reset [
	[ pingsStack isNotEmpty ]
		whileTrue: [ self finishSync ].

	recordings removeAll.
	pingsStack removeAll
]

{ #category : #'private - lifecycle' }
MemoryTelemetry >> startSync: aNameBlock [
	| aNewTask aRealStart aGcTime aSender |
	
	aRealStart := Time microsecondClockValue.
	aGcTime := Smalltalk vm totalGCTime.
	
	aNewTask := TelemetryPing new.
	aNewTask name: aNameBlock value.
	
	pingsStack
		ifEmpty: [ recordings add: aNewTask ]
		ifNotEmpty: [ pingsStack top addPing: aNewTask ].

	pingsStack push: aNewTask.

	aSender := thisContext sender sender sender.
	[ aSender := aSender sender ] doWhileTrue: [
		| aSelector |
		aSelector := aSender selector.
	 	aSelector = #time:during: or: [ aSelector = #timeSync:during: ] ].
	aNewTask sender: aSender compiledCode.
	aNewTask realStartTime: aRealStart.
	aNewTask recordOverheadStartTime.
	aNewTask startTime: Time microsecondClockValue.
]

{ #category : #'api - telemetry' }
MemoryTelemetry >> time: aNameBlock during: aBlock [
	^ [
		self startSync: aNameBlock.
		aBlock ensure: [ self finishSync ] ] valueUnpreemptively
]
