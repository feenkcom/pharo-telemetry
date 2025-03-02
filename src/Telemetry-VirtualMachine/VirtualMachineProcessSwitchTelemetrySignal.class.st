Class {
	#name : #VirtualMachineProcessSwitchTelemetrySignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'alive',
		'stack'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineProcessSwitchTelemetrySignal >> gtStackFor: aView [
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

{ #category : #'as yet unclassified' }
VirtualMachineProcessSwitchTelemetrySignal >> isAlive: aBoolean [
	alive := aBoolean
]

{ #category : #testing }
VirtualMachineProcessSwitchTelemetrySignal >> isPaused [
	^ alive not
]

{ #category : #testing }
VirtualMachineProcessSwitchTelemetrySignal >> isResumed [
	^ alive
]
