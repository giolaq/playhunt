library playhunt.browser;

import 'dart:async';
import 'dart:html';

import 'common.dart';
import 'http.dart' as http;
export 'common.dart';

class _BrowserHttpClient extends http.Client {
  @override
  Future<http.Response> request(http.Request request) {
    var req = new HttpRequest();
    var completer = new Completer<http.Response>();

    req.open(request.method, request.url);

    if (request.headers != null) {
      for (var header in request.headers.keys) {
        req.setRequestHeader(header, request.headers[header]);
      }
    }

    req.onLoadEnd.listen((event) {
      completer.complete(
          new http.Response(req.responseText, req.responseHeaders, req.status));
    });

    req.send(request.body);

    return completer.future;
  }
}

void initPlayHunt() {
  PlayHunt.defaultClient = () => new _BrowserHttpClient();
}

/**
 * Creates a PlayHunt Client
 */
PlayHunt createPlayHuntClient(
    { String endpoint: "http://localhost:8080"}) {
  initPlayHunt();
  return new PlayHunt(endpoint: endpoint);
}