/*
 * Package : Coap
 * Author : Jan Romann <jan.romann@uni-bremen.de>
 * Date   : 02/15/2022
 * Copyright :  Jan Romann
 */

part of coap;

class CoapMulticastExchange extends CoapExchange {
  CoapMulticastExchange(CoapRequest request, CoapOrigin origin,
      {required namespace})
      : super(request, origin, namespace: namespace);

  final List<CoapResponse> responses = [];

  bool alreadyReceived(CoapResponse response) {
    final filteredResponses = responses.where((element) =>
        element.source?.address.address == response.source?.address.address);

    return filteredResponses.isNotEmpty;
  }
}