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
				spec repository: 'github://feenkcom/pharo-beacon:2086a213134e50302a6498d81d5489dbcee97c52/repository' ].

		spec package: 'Telemetry' with: [
			spec requires: #('BeaconCore') ].
	]
]
