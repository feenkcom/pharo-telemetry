Class {
	#name : #VirtualMachineTelemetryAssociation,
	#superclass : #Association,
	#instVars : [
		'hash'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetryAssociation >> hash1 [
	^ hash
]

{ #category : #accessing }
VirtualMachineTelemetryAssociation >> hash: anObject [
	hash := anObject
]
