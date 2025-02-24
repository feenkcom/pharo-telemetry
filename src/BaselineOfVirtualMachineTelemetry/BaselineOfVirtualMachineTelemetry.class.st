Class {
	#name : #BaselineOfVirtualMachineTelemetry,
	#superclass : #BaselineOf,
	#category : #BaselineOfVirtualMachineTelemetry
}

{ #category : #'as yet unclassified' }
BaselineOfVirtualMachineTelemetry class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		, {BaselineOfBrick}
]

{ #category : #accessing }
BaselineOfVirtualMachineTelemetry >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec baseline: 'Telemetry' with: [
			spec repository: 'github://feenkcom/pharo-telemetry:main/src' ].
		spec baseline: 'FuturesTelemetry' with: [
			spec repository: 'github://feenkcom/pharo-futures:main/src' ].
		spec baseline: 'GToolkitFileUtility' with: [
			spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ].
		spec 
			package: #'Telemetry-VirtualMachine' with: [ spec requires: #('Telemetry' 'GToolkitFileUtility'). ].
		spec package: #'Telemetry-VirtualMachine-Extensions' with: [ spec requires: #('Telemetry-VirtualMachine' 'FuturesTelemetry'). ]. ].
]
