/*
 * Package : Coap
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/06/2018
 * Copyright :  S.Hamblett
 *
 * A simple ping request
 */

import 'dart:async';
import 'dart:io';
import 'package:coap/coap.dart';

FutureOr<void> main(List<String> args) async {
  // Create a configuration class. Logging levels can be specified in the configuration file
  final CoapConfig conf = CoapConfig(File('example/config_all.yaml'));

  // Build the request uri, note that the request paths/query parameters can be changed
  // on the request anytime after this initial setup.
  const String host = 'localhost';

  final Uri uri = Uri(scheme: 'coap', host: host, port: conf.defaultPort);

  // Create the client.
  // The method we are using creates its own request so we do not need to supply one.
  // The current request is always available from the client.
  final CoapClient client = CoapClient(uri, conf);

  print(
      'EXAMPLE - Ping client, sending ping request to $host, waiting for response....');

  // Do the discovery, note that using this method forces the path to be .well-known/core
  final bool pingOk = await client.doPing(10000);

  if (pingOk) {
    print('EXAMPLE - Ping response OK ');
  } else {
    print('EXAMPLE  - Ping failed');
  }
}