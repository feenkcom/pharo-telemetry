Class {
	#name : #VirtualMachineTelemetryEvents,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#instVars : [
		'process',
		'startTime',
		'endTime'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> addEvents: aCollectionOfSignals [
	self addAll: aCollectionOfSignals.
	items sort: [ :a :b | a startTime < b startTime ].
	startTime := items
		inject: items first startTime
		into: [ :anEndTime :each | anEndTime min: each startTime ].
	endTime := items
		inject: items first endTime
		into: [ :anEndTime :each | anEndTime max: each endTime ].
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> allPauses [
	^ self items select: [ :each | each isPausedEvent ]
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> allSemaphoreWaits [
	^ self items select: [ :each | each isPausedEvent and: [ each isWaitingOnSemaphore ] ]
]

{ #category : #accessing }
VirtualMachineTelemetryEvents >> duration [
	^ self endTime - self startTime
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> endTime [
	^ endTime
]

{ #category : #views }
VirtualMachineTelemetryEvents >> gtInfoFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 3;
		items: [ {'Priority' -> process priority.
				'Duration' -> self duration gtPreciseHumanReadableString } ];
		column: 'Property'
			text: [ :each | each key gtDisplayString asRopedText foreground: Color gray ];
		column: 'Value' text: [ :each | each value gtDisplayString ]
]

{ #category : #views }
VirtualMachineTelemetryEvents >> gtLocksFor: aView [
	<gtView>
	
	self pausesDueToLocks
		ifEmpty: [ ^ aView empty ].
		
	^ aView columnedList
		title: 'Locks';
		priority: 7;
		items: [ self pausesDueToLocks ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Timestamp' 
			text: [ :eachItem | eachItem startTime ];
		column: 'Duration' 
			text: [ :eachItem |
				| durationColor |
				
				durationColor := eachItem duration <= 1 milliSecond
					ifTrue:  [ Color gray ]
					ifFalse: [ Color red ].
			
				eachItem duration gtPreciseHumanReadableString asRopedText foreground: durationColor ].
]

{ #category : #views }
VirtualMachineTelemetryEvents >> gtSemaphoreWaitsFor: aView [
	<gtView>
	
	self allSemaphoreWaits
		ifEmpty: [ ^ aView empty ].
		
	^ aView columnedList
		title: 'Pauses';
		priority: 9;
		items: [ self allSemaphoreWaits ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Timestamp' 
			text: [ :eachItem | eachItem startTime ];
		column: 'Duration' 
			text: [ :eachItem |				
				eachItem duration gtPreciseHumanReadableString ];
		column: 'Type' 
			text: [ :eachItem |
				eachItem reasonSignal isLocked
					ifTrue: [ 'Locked on a mutual exclusion' asRopedText  foreground: Color red ]
					ifFalse: [ 'Waiting on a semaphore' asRopedText  foreground: Color gray ] ].
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> lockOrWorkEvents [
	^ self select: [ :eachEvent | eachEvent isResumedEvent or: [ eachEvent isPausedEvent and: [ eachEvent isLockedOnSemaphore ] ] ]
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> pausesDueToLocks [
	^ self items select: [ :each | each isPausedEvent and: [ each isLockedOnSemaphore ] ]
]

{ #category : #accessing }
VirtualMachineTelemetryEvents >> process [
	^ process
]

{ #category : #accessing }
VirtualMachineTelemetryEvents >> process: anObject [
	process := anObject
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> startTime [
	^ startTime
]
