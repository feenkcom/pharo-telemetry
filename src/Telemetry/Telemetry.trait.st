Trait {
	#name : #Telemetry,
	#category : #'Telemetry-Telemetries'
}

{ #category : #accessing }
Telemetry >> beacon: aBeaconSignal as: aSymbol on: aBlock [
	^ self
		profile: aBlock
		executing:  [ :blockClosure |
			| aLogger |
			
			aLogger := MemoryLogger new.
			aLogger startFor: aBeaconSignal.
			
			blockClosure value.
			
			aLogger stop.
			aLogger recordings ]
		as: aSymbol
]

{ #category : #accessing }
Telemetry >> beacon: aBeaconSignal on: aBlock [
	^ self
		beacon: aBeaconSignal
		as: #beacon
		 on: aBlock
]

{ #category : #'api - telemetry' }
Telemetry >> emit [
	self emitAs: self
]

{ #category : #'api - telemetry' }
Telemetry >> emitAs: aSourceTelemetry [
	
]

{ #category : #accessing }
Telemetry >> messageTallyOn: aBlock [
	^ self
		profile: aBlock
		executing:  [ :blockClosure |
			| aTally |
			aTally := MessageTally new
				reportOtherProcesses: false;
				maxClassNameSize: 1000;
				maxClassPlusSelectorSize: 1000;
				maxTabs: 100;
				yourself.
			aTally
				spyEvery: 1
				on: blockClosure.
			aTally ]
		as: #tally
]

{ #category : #accessing }
Telemetry >> profile: aBlock executing: aCollectingBlock as: aSymbolKey [
	"Record an extra telemetry data associating it with a given key"
]

{ #category : #'api - telemetry' }
Telemetry >> reset [
]

{ #category : #accessing }
Telemetry >> snapshotSpace: aSpace [
	self
		profile: []
		executing:  [ :blockClosure |			
			blockClosure value.
			(aSpace root
				asSpartaForm: nil
				scaleFactor: 0.5
				hdpiScaleFactor: 1) -> aSpace extent ]
		as: #spaceSnapshot
]

{ #category : #accessing }
Telemetry >> snapshotSpace: aSpace after: aBlock [
	^ self
		profile: aBlock
		executing:  [ :blockClosure |			
			blockClosure value.
			aSpace
				asSpartaForm: nil
				scaleFactor: nil
				hdpiScaleFactor: aSpace scaleFactor ]
		as: #spaceSnapshot
]

{ #category : #'api - telemetry' }
Telemetry >> time: aNameBlock during: aBlock [
	^ self explicitRequirement
]

{ #category : #'api - telemetry' }
Telemetry >> timeSync: aNameBlock during: aBlock [
	^ self time: aNameBlock during: aBlock
]
