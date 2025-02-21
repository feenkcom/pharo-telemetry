Extension { #name : #VirtualMachineThisProcessSwitchTelemetry }

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineThisProcessSwitchTelemetry >> gtPauseEventsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pauses';
		priority: 1;
		items: [ self pauseEvents ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Duration' 
			text: [ :eachItem | eachItem duration gtPreciseHumanReadableString ];
		column: 'Reason'
			text: [ :eachItem | eachItem printHumanReadablePauseReason ];
		column: 'Timestamp'
			text: [ :eachItem | eachItem startTime ];
		actionUpdateButton
]

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineThisProcessSwitchTelemetry >> gtSignalsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Signals';
		priority: 2;
		items: [ self signals ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Status' 
			text: [ :eachItem | eachItem statusText ];
		column: 'Timestamp'
			text: [ :eachItem | eachItem timestamp ];
		actionUpdateButton
]
