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
				spec repository: 'github://feenkcom/pharo-beacon:e383509fecbed09eb5302997af86b5574830ff35/repository' ].

		spec package: 'Telemetry' with: [
			spec requires: #(#BeaconCore) ].
	]
]
