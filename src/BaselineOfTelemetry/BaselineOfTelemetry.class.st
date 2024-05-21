Class {
	#name : #BaselineOfTelemetry,
	#superclass : #BaselineOf,
	#category : #BaselineOfTelemetry
}

{ #category : #baseline }
BaselineOfTelemetry >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'BeaconCore' with: [
				spec repository: 'github://feenkcom/pharo-beacon:0c75fd0e470f98f9b103a4656e879b728aaecfd3/repository' ].

		spec package: 'Telemetry' with: [
			spec requires: #('BeaconCore') ].
	]
]
