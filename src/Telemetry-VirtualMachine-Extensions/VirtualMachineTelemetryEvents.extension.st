Extension { #name : #VirtualMachineTelemetryEvents }

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
		column: 'Duration' 
			text: [ :eachItem |
				| durationColor |
				
				durationColor := eachItem duration <= 1 milliSecond
					ifTrue:  [ Color gray ]
					ifFalse: [ Color red ].
			
				eachItem duration gtPreciseHumanReadableString asRopedText foreground: durationColor ].
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
					ifTrue: [ 'Locked on a mutual exclusion' asRopedText  foreground: Color red ]
					ifFalse: [ 'Waiting on a semaphore' asRopedText  foreground: Color gray ] ].
]
