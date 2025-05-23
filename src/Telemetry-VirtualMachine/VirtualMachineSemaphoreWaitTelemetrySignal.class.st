Class {
	#name : #VirtualMachineSemaphoreWaitTelemetrySignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'semaphore',
		'isLocked',
		'stack'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #views }
VirtualMachineSemaphoreWaitTelemetrySignal >> gtStackFor: aView [
	<gtView>
	stack ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Stack';
		items: [ stack ];
		priority: 5;
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Method' text: [ :each | each gtDisplayString ]
]

{ #category : #testing }
VirtualMachineSemaphoreWaitTelemetrySignal >> isLocked [
	isLocked ifFalse: [ ^ false ].

	(semaphore isKindOf: AsyncSemaphoreForMutualExclusion)
		ifTrue: [ ^ true ].

	self isWaitingOnFuture
		ifTrue: [ ^ true ].
		
	self isLockedOnMonitor
		ifTrue: [ ^ true ].
		
	self isLockedOnSocket
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #'as yet unclassified' }
VirtualMachineSemaphoreWaitTelemetrySignal >> isLockedOnMonitor [
	stack ifNil: [ ^ false ].
	
	^ stack anySatisfy: [ :eachMethod |
		eachMethod isNotNil and: [
			eachMethod selector = #enter and: [ eachMethod origin = Monitor ] ] ]
]

{ #category : #'as yet unclassified' }
VirtualMachineSemaphoreWaitTelemetrySignal >> isLockedOnSocket [
	stack ifNil: [ ^ false ].
	
	^ stack anySatisfy: [ :eachMethod |
		eachMethod isNotNil and: [
			eachMethod selector = #waitForConnectionFor:ifTimedOut: and: [ eachMethod origin = Socket ] ] ]
]

{ #category : #testing }
VirtualMachineSemaphoreWaitTelemetrySignal >> isWaiting [
	^ isLocked
]

{ #category : #'as yet unclassified' }
VirtualMachineSemaphoreWaitTelemetrySignal >> isWaitingOnFuture [
	stack ifNil: [ ^ false ].
	
	^ stack anySatisfy: [ :eachMethod |
		eachMethod isNotNil and: [
			eachMethod selector = #wait and: [ eachMethod origin = TAsyncFuture ] ] ]
]

{ #category : #accessing }
VirtualMachineSemaphoreWaitTelemetrySignal >> semaphore [
	^ semaphore
]

{ #category : #accessing }
VirtualMachineSemaphoreWaitTelemetrySignal >> stack [
	^ stack
]
