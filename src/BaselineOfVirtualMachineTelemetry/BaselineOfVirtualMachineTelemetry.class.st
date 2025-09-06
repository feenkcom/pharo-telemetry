Class {
	#name : #BaselineOfVirtualMachineTelemetry,
	#superclass : #BaselineOf,
	#category : #BaselineOfVirtualMachineTelemetry
}

{ #category : #accessing }
BaselineOfVirtualMachineTelemetry class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines,
		{ BaselineOfBrick . BaselineOfGToolkitVisualizer }
]

{ #category : #baseline }
BaselineOfVirtualMachineTelemetry >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Telemetry' with: [
				spec repository: 'github://feenkcom/pharo-telemetry:v0.6.108/src' ].
		spec
			baseline: 'GToolkitFileUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.395/src' ].

		spec package: 'Telemetry-VirtualMachine' with: [
			spec requires: #(#Telemetry #GToolkitFileUtility) ].
		spec package: 'Telemetry-VirtualMachine-Extensions' with: [
			spec requires: #(#'Telemetry-VirtualMachine') ].
	]
]
