Extension { #name : #VirtualMachineProcessSwitchTelemetrySignal }

{ #category : #'*Telemetry-VirtualMachine-Extensions' }
VirtualMachineProcessSwitchTelemetrySignal >> statusText [
	^ self isPaused
		ifTrue: [ 'Paused' asRopedText foreground: BrGlamorousColors linkWithErrorColor ]
		ifFalse: [ 'Resumed' asRopedText foreground: BrGlamorousColors successBorderColor ]
]
