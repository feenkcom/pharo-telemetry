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
				spec repository: 'github://feenkcom/pharo-beacon:93329815ac3935bcbf46b3e38b83324b5a32ac37/repository' ].

		spec package: 'Telemetry' with: [
			spec requires: #('BeaconCore') ].
	]
]
