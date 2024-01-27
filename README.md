# pharo-telemetry
Performance telemetry collection infrastructure based on Beacon

# pharo-vm-telemetry
Extends Cog Interpreter with detailed performance and memory telemetry.
Requires installed VMMaker.

```smalltalk
EpMonitor disableDuring: [
  Author useAuthor: 'Load' during: [
    Metacello new
      baseline: 'CoInterpreterTelemetry';
      repository: 'github://feenkcom/pharo-telemetry:main/src';
      load ] ].
```
