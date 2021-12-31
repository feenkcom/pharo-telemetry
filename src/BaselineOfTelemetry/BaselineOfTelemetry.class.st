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
				spec repository: 'github://feenkcom/pharo-beacon:7d7c3cd9829e5a7e238bbfb9a3bcdf84b5e562da/repository' ].

		spec package: 'Telemetry' with: [
			spec requires: #('BeaconCore') ].
	]
]
