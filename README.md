# [OSignal schema](https://github.com/osignal/schema)
Open format for storing and transferring high-frequency device telemetry.

Based on [Flatbuffers](https://flatbuffers.dev/), a widely-used open-source technology.

## `Message`

Provides high-performance encoding of signals.
    
Data points for independent signals are encoded first, in a
compact form, and ordered by timestamp:

```
  data_points:     [DataPoint]      (id: 2); // flat, all points in this batch
```

### `DataPoint`
Each data point is encoded in a fixed-length memory layout (a `struct` in
Flatbuffers):

```
struct DataPoint {
  signal_idx:  uint   (id: 0); // index into Message.signals
  ts_unix_ns:  ulong  (id: 1); // timestamp (ns)
  value:       double (id: 2); // primary numeric value (Float64 hot path)
  flags:       uint   (id: 3); // DPFlags bitfield
}
```

and includes a reference to its associated signal metadata.

### `Signal`

```
table Signal {
  source_idx:          uint         (id: 0); // index into Message.sources
  id64:                ulong        (id: 1); // optional stable ID (cross-file)
  name:                string       (id: 2);
  unit:                string       (id: 3); // e.g., "V", "A", "°C"
  description:         string       (id: 4);
  ...
}
```

Each signal has a reference to a description of the source which
acquired that signal.

### `Source`
```
table Source {
  id64:        ulong      (id: 0); // stable ID for cross-file joins
  name:        string     (id: 1); // human label or hostname
  description: string     (id: 2);
  hw_model:    string     (id: 3);
  hw_serial:   string     (id: 4);
  sw_version:  string     (id: 5);
  tags:        [KeyValue] (id: 6);
}
```
