Class {
	#name : #VirtualMachineProcessSwitchTelemetry,
	#superclass : #Object,
	#instVars : [
		'id',
		'signals',
		'currentProcess',
		'contextSwitchSignalClass',
		'semaphoreWaitSignalClass'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineProcessSwitchTelemetry class >> spyOn: aBlock [
	<return: #VirtualMachineTelemetry>
	| aTelemetry |

	aTelemetry := self basicNewPinned
		initialize;
		yourself.
	
	aTelemetry start.
	aBlock ensure: [ aTelemetry stop ].
	^ aTelemetry
]

{ #category : #accessing }
VirtualMachineProcessSwitchTelemetry >> gtSignalsFor: aView [
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

{ #category : #'as yet unclassified' }
VirtualMachineProcessSwitchTelemetry >> initialize [
	super initialize.
	
	id := 0.
	signals := OrderedCollection new: 100.
	currentProcess := Processor activeProcess.
	contextSwitchSignalClass := VirtualMachineProcessSwitchTelemetrySignal.
	semaphoreWaitSignalClass := VirtualMachineSemaphoreWaitTelemetrySignal
]

{ #category : #'private - primitives' }
VirtualMachineProcessSwitchTelemetry >> primStartTelemetry [
	<primitive: #primitiveStartProcessSwitchTelemetry>
	
	^ self primitiveFailed
]

{ #category : #'private - primitives' }
VirtualMachineProcessSwitchTelemetry >> primStopTelemetry: anId [
	<primitive: #primitiveStopTelemetry>
	
	^ self primitiveFailed
]

{ #category : #accessing }
VirtualMachineProcessSwitchTelemetry >> signals [
	^ signals
]

{ #category : #accessing }
VirtualMachineProcessSwitchTelemetry >> start [
	self primStartTelemetry
]

{ #category : #accessing }
VirtualMachineProcessSwitchTelemetry >> stop [
	self primStopTelemetry: id.
	self setPinnedInMemory: false
]
