Class {
	#name : #VirtualMachineTelemetryIdentityDictionary,
	#superclass : #IdentityDictionary,
	#instVars : [
		'associationClass'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryIdentityDictionary >> associationClass [
	^ Association
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryIdentityDictionary >> initialize [
	super initialize.
	
	associationClass := self associationClass
]

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryIdentityDictionary >> initialize: n [
	super initialize: n.
	
	associationClass := self associationClass
]
