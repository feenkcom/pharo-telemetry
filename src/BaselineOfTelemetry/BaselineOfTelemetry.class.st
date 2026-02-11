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
				spec repository: 'github://feenkcom/pharo-beacon:51b6f4ddc42f17190eea2eaad3a08099cd4984cb/repository' ].

		spec package: 'Telemetry' with: [
			spec requires: #(#BeaconCore) ].
	]
]
