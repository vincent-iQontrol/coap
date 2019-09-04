/*
 * Package : Coap
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 21/05/2018
 * Copyright :  S.Hamblett
 */

part of coap;

/// Sweep deduplicator
class CoapSweepDeduplicator implements CoapIDeduplicator {
  /// Construction
  CoapSweepDeduplicator(CoapConfig config) {
    _config = config;
  }

  static CoapILogger _log = CoapLogManager().logger;

  Map<CoapKeyId, CoapExchange> _incomingMessages =
      Map<CoapKeyId, CoapExchange>();
  Timer _timer;
  CoapConfig _config;

  @override
  void start() {
    _timer ??= Timer.periodic(
        Duration(milliseconds: _config.markAndSweepInterval), _sweep);
  }

  @override
  void stop() {
    _timer.cancel();
    _timer = null;
  }

  @override
  void clear() {
    stop();
    _incomingMessages.clear();
  }

  @override
  CoapExchange findPrevious(CoapKeyId key, CoapExchange exchange) {
    CoapExchange prev;
    if (_incomingMessages.containsKey(key)) {
      prev = _incomingMessages[key];
    }
    _incomingMessages[key] = exchange;
    return prev;
  }

  @override
  CoapExchange find(CoapKeyId key) {
    if (_incomingMessages.containsKey(key)) {
      return _incomingMessages[key];
    }
    return null;
  }

  void _sweep(Timer timer) {
    _log.debug('Start Mark-And-Sweep with ${_incomingMessages.length} entries');

    final DateTime oldestAllowed = DateTime.now()
      ..add(Duration(milliseconds: _config.exchangeLifetime));
    final List<CoapKeyId> keysToRemove = List<CoapKeyId>();
    _incomingMessages.forEach((CoapKeyId key, CoapExchange value) {
      if (value.timestamp.isBefore(oldestAllowed)) {
        _log.debug('Mark-And-Sweep removes $key');
        keysToRemove.add(key);
      }
    });
    keysToRemove.forEach(_incomingMessages.remove);
  }
}
