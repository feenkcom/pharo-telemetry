Extension { #name : #VirtualMachineAllProcessesSwitchTelemetry }

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineAllProcessesSwitchTelemetry >> gtProcessesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Signals by process';
		priority: 7;
		object: [ self eventsByProcess ];
		view: #gtProcessesFor:
]

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineAllProcessesSwitchTelemetry >> gtTimelineFor: aView [
	<gtView>
	^ aView forward
		title: 'Timeline';
		priority: 5;
		object: [ self eventsByProcess ];
		view: #gtTimelineFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect events'
			action: [ :aButton | aButton phlow spawnObject: self eventsByProcess ]
]
