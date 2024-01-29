Class {
	#name : #VirtualMachineTelemetryMethodSwitchSignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'method'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryMethodSwitchSignal >> gtSourceCodeFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Source';
		priority: 2;
		object: [ method ];
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
VirtualMachineTelemetryMethodSwitchSignal >> method [
	^ method
]

{ #category : #accessing }
VirtualMachineTelemetryMethodSwitchSignal >> printOn: aStream [ 
	"Overrides method inherited from the byte arrayed collection."
	
	aStream
		nextPutAll: 'Method switched';
		space;
		nextPutAll: 'to';
		space;
		print: self method
]
