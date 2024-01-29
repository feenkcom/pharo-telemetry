Class {
	#name : #VirtualMachineTelemetrySignalGroup,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'Telemetry-VirtualMachine'
}

{ #category : #accessing }
VirtualMachineTelemetrySignalGroup >> asArray [
	^ Array streamContents: [ :s | self do: [ :each | s nextPut: each ] ]
]

{ #category : #accessing }
VirtualMachineTelemetrySignalGroup >> collection [
	^ collection
]

{ #category : #accessing }
VirtualMachineTelemetrySignalGroup >> collection: anObject [
	collection := anObject
]

{ #category : #accessing }
VirtualMachineTelemetrySignalGroup >> do: aBlock [
	| index |

	index := 1.
	[ index <= collection size ] whileTrue: [
		aBlock value: (collection at: index).
		index := index + 1 ]
]

{ #category : #accessing }
VirtualMachineTelemetrySignalGroup >> first: n [
	^ self class new collection: (Array streamContents: [ :s |
		| index |
		
		index := 1.
		[ index <= collection size and: [ index <= n ] ] whileTrue: [
			s nextPut: (collection at: index).
			index := index + 1 ] ])
]

{ #category : #accessing }
VirtualMachineTelemetrySignalGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Items';
		priority: 2;
		items: [ self asArray ];
		column: 'Index' text: [ :each :i | i ] width: 50;
		column: 'Signal' text: [ :each | each ];
		column: 'Execution'
			text: [ :each | each isReturnSignal ifTrue: [ each executionLocationName ] ifFalse: [ '' ] ]
			width: 150;
		column: 'Source'
			text: [ :each | each isReturnSignal ifTrue: [ each sourceIdName asRopedText glamorousRegularSmallSize ] ifFalse: [ '' ] ]
			width: 200;
		column: 'Frame pointer'
			text: [ :each | (each framePointer ifNil: [ '' ] ifNotNil: [ :anAddress | anAddress printString ]) ]
			width: 120;
		actionUpdateButton
]

{ #category : #accessing }
VirtualMachineTelemetrySignalGroup >> printOn: aStream [
	super printOn: aStream.
	
	aStream
		space;
		nextPut: $(;
		print: self size;
		nextPut: $)
]

{ #category : #accessing }
VirtualMachineTelemetrySignalGroup >> select: aBlock [
	| aCollection |
	aCollection := OrderedCollection streamContents: [ :aStream |
		self do: [ :each | (aBlock value: each)
			ifTrue: [ aStream nextPut: each ] ] ].
	^ self class new collection: aCollection
]

{ #category : #accessing }
VirtualMachineTelemetrySignalGroup >> size [
	^ collection size
]

{ #category : #accessing }
VirtualMachineTelemetrySignalGroup >> withIndexDo: aBlock [ 
	| index |
	
	index := 0.
	self do: [ :each |
		index := index + 1.
		aBlock
			value: each
			value: index ]
]
