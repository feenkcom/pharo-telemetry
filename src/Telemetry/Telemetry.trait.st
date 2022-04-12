Trait {
	#name : #Telemetry,
	#category : #'Telemetry-Telemetries'
}

{ #category : #'api - telemetry' }
Telemetry >> emit [
	self emitAs: self
]

{ #category : #'api - telemetry' }
Telemetry >> emitAs: aSourceTelemetry [
	
]

{ #category : #'api - telemetry' }
Telemetry >> reset [
]

{ #category : #'api - telemetry' }
Telemetry >> time: aNameBlock during: aBlock [
	^ self explicitRequirement
]

{ #category : #'api - telemetry' }
Telemetry >> timeSync: aNameBlock during: aBlock [
	^ self time: aNameBlock during: aBlock
]
