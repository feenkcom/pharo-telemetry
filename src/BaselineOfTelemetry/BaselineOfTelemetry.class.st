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
				spec repository: 'github://feenkcom/pharo-beacon:a05be31f52be3204af17d0b70d2a678c2532c337/repository' ].

		spec package: 'Telemetry' with: [
			spec requires: #('BeaconCore') ].
	]
]
