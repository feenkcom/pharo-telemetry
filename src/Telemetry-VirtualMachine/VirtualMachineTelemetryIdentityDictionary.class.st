Class {
	#name : #VirtualMachineTelemetryIdentityDictionary,
	#superclass : #IdentityDictionary,
	#instVars : [
		'associationClass'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryIdentityDictionary >> initialize [
	super initialize.
	
	associationClass := Association
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryIdentityDictionary >> initialize: n [
	super initialize: n.
	
	associationClass := Association
]
