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
VirtualMachineTelemetryEvents >> allComputations [
	^ self items select: [ :each | each isComputationEvent ]
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> allPauses [
	^ self items select: [ :each | each isPausedEvent ]
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> allSemaphoreWaits [
	^ self items select: [ :each | each isPausedEvent and: [ each isWaitingOnSemaphore ] ]
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> allWorkEvents [
	^ self items select: [ :each | each isResumedEvent ]
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> cpuTimeBetween: aStartDate and: anEndDate [
	^ (anEndDate - aStartDate) - (self pausesBetween: aStartDate and: anEndDate)
]

{ #category : #accessing }
VirtualMachineTelemetryEvents >> duration [
	^ self endTime - self startTime
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> endTime [
	^ endTime
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> lockOrWorkEvents [
	^ self
		select: [ :eachEvent | 
			eachEvent isResumedEvent
				or: [ eachEvent isComputationEvent
						or: [ eachEvent isPausedEvent and: [ eachEvent isLockedOnSemaphore ] ] ] ]
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEvents >> pausesBetween: aStartDate and: anEndDate [
	| relatedPauseEvents |
	
	relatedPauseEvents := self allPauses select: [ :eachEvent |
		(eachEvent startTime between: aStartDate and: anEndDate)
			and: [ (eachEvent endTime between: aStartDate and: anEndDate) ] ].
	
	^ relatedPauseEvents
		inject: 0 seconds
		into: [ :totalDuration :each | totalDuration + each duration ]
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
