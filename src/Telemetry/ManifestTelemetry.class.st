"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestTelemetry,
	#superclass : #PackageManifest,
	#category : #'Telemetry-Manifest'
}

{ #category : #accessing }
ManifestTelemetry class >> mustOnlyDependOn [
	^ {
		'Announcements-Core'.
		'Beacon-Core'.
		'Collections-Sequenceable'.
		'Collections-Stack'.
		'Collections-Unordered'.
		'Kernel'.
		'Tool-Profilers'.
	}, (self  
		forPharo12AndNewer: [{
			'System-Time' .}] 
		forPharo11: [{}])
]

{ #category : #testing }
ManifestTelemetry class >> shouldValidateBaseline [
	^ true
]
