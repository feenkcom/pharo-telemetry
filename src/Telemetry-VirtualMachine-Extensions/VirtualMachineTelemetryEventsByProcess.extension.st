Extension { #name : #VirtualMachineTelemetryEventsByProcess }

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineTelemetryEventsByProcess >> gtProcessesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Signals by process';
		priority: 7;
		items: [ self ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Process' 
			text: [ :eachItem | eachItem process gtName ]
			weight: 0.6;
		column: 'Priority' 
			text: [ :eachItem | eachItem process priority ]
			width: 60;
		column: 'Amount of signals'
			text: [ :eachItem | eachItem items size ]
			weight: 0.4;
		send: [ :eachItem | eachItem ];
		actionUpdateButton
]

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineTelemetryEventsByProcess >> gtStatisticFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Info';
		priority: 3;
		items: [ {
			'Active processes' -> self size.
		} ];
		column: 'Property' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		actionUpdateButton
]

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineTelemetryEventsByProcess >> gtTimelineFor: aView [
	<gtView>
	^ aView explicit
		title: 'Timeline';
		priority: 5;
		stencil: [
			GtMonitorFutureWorkerHorizontalChartStencil new
				leftPadding: 20;
				labelWidth: 250;
				labelFontSize: 12;
				rowHeight: 20;
				barHeight: 10;
				withoutGridlines;
				withoutTickLabels;
				startTimeComputation: #startTime;
				endTimeComputation: #endTime;
				colorComputation: [ :each |
					each isResumedEvent
						ifTrue: [ Color blue ]
						ifFalse: [ each isLockedOnSemaphore
							ifTrue: [ Color red ]
							ifFalse: [ Color transparent ] ] ];
				executionGeometryComputation: [ :each | BlRectangleGeometry new ];
				rowValuesComputation: #lockOrWorkEvents;
				rowLabelComputation: [ :each | each process gtShortName ];
				executions: self ];
		actionUpdateButton
]
