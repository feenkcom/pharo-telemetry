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
				spec repository: 'github://feenkcom/pharo-beacon:676efa9751879dc8935145e1be7f7700cfbbbcfc/repository' ].

		spec package: 'Telemetry' with: [
			spec requires: #(#BeaconCore) ].
	]
]
