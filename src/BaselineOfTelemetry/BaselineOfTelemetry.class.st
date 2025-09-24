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
				spec repository: 'github://feenkcom/pharo-beacon:77c26a9194d7e0494d56f0f1b86c55fc08925cf5/repository' ].

		spec package: 'Telemetry' with: [
			spec requires: #(#BeaconCore) ].
	]
]
