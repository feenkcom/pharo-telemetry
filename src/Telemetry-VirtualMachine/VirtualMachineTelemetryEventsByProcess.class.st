Class {
	#name : #VirtualMachineTelemetryEventsByProcess,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #'as yet unclassified' }
VirtualMachineTelemetryEventsByProcess >> mergedByParentProcess [
	| byProcessDictionary|
	
	byProcessDictionary := OrderedDictionary new: self size.
	self do: [ :each | byProcessDictionary at: each process put: each ].
	
	self do: [ :each |
		AsyncProcessProperties
			process: each process
			property: #parentProcess
			ifPresent: [ :aParentProcess |
				byProcessDictionary
					at: aParentProcess
					ifPresent: [ :parentEvents |
						(byProcessDictionary removeKey: each process ifAbsent: [ nil ])
							ifNotNil: [ :childEvents |
								parentEvents addEvents: childEvents
							].
					].
			]
	].
	
	^ self class new addAll: byProcessDictionary values
]
