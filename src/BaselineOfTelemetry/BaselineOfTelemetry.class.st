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
				spec repository: 'github://feenkcom/pharo-beacon:df86603dd9fbb2f85a657a5d52bbb47731f75cc4/repository' ].

		spec package: 'Telemetry' with: [
			spec requires: #(#BeaconCore) ].
	]
]
