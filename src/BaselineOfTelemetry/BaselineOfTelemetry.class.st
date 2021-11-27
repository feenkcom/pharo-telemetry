Class {
	#name : #BaselineOfTelemetry,
	#superclass : #BaselineOf,
	#category : #BaselineOfTelemetry
}

{ #category : #baselines }
BaselineOfTelemetry >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec baseline: 'BeaconCore' with: [
			spec repository: 'github://feenkcom/pharo-beacon/repository' ].
		spec 
			package: #'Telemetry' with: [ spec requires: #('BeaconCore'). ]. ].
]
