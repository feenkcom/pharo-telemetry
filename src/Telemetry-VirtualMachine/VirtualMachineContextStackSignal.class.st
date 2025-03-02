Class {
	#name : #VirtualMachineContextStackSignal,
	#superclass : #VirtualMachineTelemetrySignal,
	#instVars : [
		'stack',
		'payload'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineContextStackSignal >> gtDisplayOn: aStream [
	stack ifNil: [ ^ super gtDisplayOn: aStream ].

	aStream nextPutAll: stack first printString
]

{ #category : #views }
VirtualMachineContextStackSignal >> gtStackFor: aView [
	<gtView>
	stack ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Stack';
		items: [ stack ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #accessing }
VirtualMachineContextStackSignal >> payload [
	^ payload
]

{ #category : #accessing }
VirtualMachineContextStackSignal >> stack [
	^ stack
]
