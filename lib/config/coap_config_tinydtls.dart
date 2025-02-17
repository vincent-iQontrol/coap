// GENERATED CODE, do not edit this file.

import 'package:coap/coap.dart';

/// Configuration loading class. The config file itself is a YAML
/// file. The configuration items below are marked as optional to allow
/// the config file to contain only those entries that override the defaults.
/// The file can't be empty, so version must as a minimum be present.
class CoapConfigTinydtls extends DefaultCoapConfig {
  @override
  String get deduplicator => 'MarkAndSweep';

  @override
  DtlsBackend? get dtlsBackend => DtlsBackend.TinyDtls;
}
