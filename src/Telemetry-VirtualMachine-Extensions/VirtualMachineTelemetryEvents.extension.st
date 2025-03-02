Extension { #name : #VirtualMachineTelemetryEvents }

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineTelemetryEvents >> gtComputationsFor: aView [
	<gtView>
	
	self allComputations
		ifEmpty: [ ^ aView empty ].
		
	^ aView columnedList
		title: 'Computations';
		priority: 10;
		items: [ self allComputations ];
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

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineTelemetryEvents >> gtEventsFor: aView [
	<gtView>
	
	self items
		ifEmpty: [ ^ aView empty ].
		
	^ aView columnedList
		title: 'Events';
		priority: 11;
		items: [ self items ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Timestamp' 
			text: [ :eachItem | eachItem startTime ];
		column: 'Event' 
			text: [ :eachItem | eachItem ];
		column: 'Duration' 
			text: [ :eachItem |			
				eachItem duration gtPreciseHumanReadableString asRopedText ].
]

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
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

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
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
		column: 'Reason' 
			text: [ :eachItem | eachItem printHumanReadablePauseReason ];
		column: 'Duration' 
			text: [ :eachItem |
				| durationColor |
				
				durationColor := eachItem duration <= 1 milliSecond
					ifTrue:  [ Color gray ]
					ifFalse: [ Color red ].
			
				eachItem duration gtPreciseHumanReadableString asRopedText foreground: durationColor ]
]

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
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
					ifTrue: [ eachItem printHumanReadablePauseReason ]
					ifFalse: [ 'Waiting on a semaphore' asRopedText  foreground: Color gray ] ];
		actionUpdateButton.
]

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineTelemetryEvents >> gtWorkFor: aView [
	<gtView>
	
	self allWorkEvents
		ifEmpty: [ ^ aView empty ].
		
	^ aView columnedList
		title: 'Work';
		priority: 9;
		items: [ self allWorkEvents ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Timestamp' 
			text: [ :eachItem | eachItem startTime ];
		column: 'Duration' 
			text: [ :eachItem |
				| durationColor |
				
				durationColor := eachItem duration <= 16 milliSecond
					ifTrue:  [ Color gray ]
					ifFalse: [ Color blue ].
			
				eachItem duration gtPreciseHumanReadableString asRopedText foreground: durationColor ].
]
