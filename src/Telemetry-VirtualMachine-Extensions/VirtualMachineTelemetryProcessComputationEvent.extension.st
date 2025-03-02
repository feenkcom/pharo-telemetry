Extension { #name : #VirtualMachineTelemetryProcessComputationEvent }

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineTelemetryProcessComputationEvent >> gtValueFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Payload';
		priority: 5;
		stencil: [ GtInspector forObject: endSignal value ]
]
