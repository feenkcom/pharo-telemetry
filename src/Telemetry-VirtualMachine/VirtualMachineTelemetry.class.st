Class {
	#name : #VirtualMachineTelemetry,
	#superclass : #Object,
	#instVars : [
		'handle',
		'signalTypes'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'private - primitives' }
VirtualMachineTelemetry class >> primDisableTelemetry [
	<primitive: #primitiveDisableTelemetry>
	
	^ self primitiveFailed
]

{ #category : #'private - primitives' }
VirtualMachineTelemetry class >> primStartTelemetry [
	<primitive: #primitiveStartTelemetry>
	
	^ self primitiveFailed
]

{ #category : #'private - primitives' }
VirtualMachineTelemetry class >> primStopTelemetry [
	<primitive: #primitiveStopTelemetry>
	
	^ self primitiveFailed
]

{ #category : #accessing }
VirtualMachineTelemetry class >> spyOn: aBlock [
	<return: #VirtualMachineTelemetry>
	| aTelemetry |

	self start.
	aBlock ensure: [ aTelemetry := self stop ].
	^ aTelemetry
]

{ #category : #accessing }
VirtualMachineTelemetry class >> start [
	self primStartTelemetry
]

{ #category : #accessing }
VirtualMachineTelemetry class >> stop [
	<return: #VirtualMachineTelemetry>
	
	self primDisableTelemetry.
	
	^ self new
		setHandle: self primStopTelemetry;
		yourself
]

{ #category : #accessing }
VirtualMachineTelemetry >> at: anIndex [
	<return: #VirtualMachineTelemetrySignal>

	^ self
		primitiveReify: signalTypes
		telemetry: handle
		signalAt: anIndex
]

{ #category : #accessing }
VirtualMachineTelemetry >> finalize [
	super finalize.
	
	self primDropTelemetry: handle.
	handle beNull.
]

{ #category : #accessing }
VirtualMachineTelemetry >> gtSignalsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Signals';
		priority: 2;
		object: [ self signals];
		view: #gtItemsFor:
]

{ #category : #'initialization ' }
VirtualMachineTelemetry >> initialize [
	super initialize.

	signalTypes := self telemetrySignalTypes
]

{ #category : #'private - primitives' }
VirtualMachineTelemetry >> primDropTelemetry: anExternalAddress [
	<primitive: #primitiveDropTelemetry>
]

{ #category : #'private - primitives' }
VirtualMachineTelemetry >> primitiveAmountOfTelemetrySignals: anExternalAddress [
	<primitive: #primitiveAmountOfTelemetrySignals>
	
	^ self primitiveFailed
]

{ #category : #'private - primitives' }
VirtualMachineTelemetry >> primitiveReify: theSignalTypes telemetry: anExternalAddress signalAt: anIndex [
	<primitive: #primitiveReifyTelemetrySignalAt>
	
	^ self primitiveFailed
]

{ #category : #'initialization ' }
VirtualMachineTelemetry >> setHandle: anExternalAddress [
	handle := anExternalAddress.
	self class finalizationRegistry add: self
]

{ #category : #accessing }
VirtualMachineTelemetry >> signals [
	^ VirtualMachineTelemetrySignalGroup new collection: self
]

{ #category : #accessing }
VirtualMachineTelemetry >> size [
	^ self primitiveAmountOfTelemetrySignals: handle
]

{ #category : #'initialization ' }
VirtualMachineTelemetry >> telemetrySignalTypes [
	"Must be in the same order as `TelemetrySignal` enum"
	^ {
		VirtualMachineTelemetrySendSignal.
		VirtualMachineTelemetryReturnSignal.
		VirtualMachineTelemetryMethodSwitchSignal.
		VirtualMachineTelemetryContextSwitchSignal
	}
]
