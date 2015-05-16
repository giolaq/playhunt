part of playhunt.common;


typedef http.Client ClientCreator();


/**
 * The Main PlayHunt Client
 *
 * ## Example
 *
 *      var playhunt = new PlayHunt(auth: new Authentication.withToken("SomeToken"));
 *      // Use the Client
 */
class PlayHunt {

  /**
   * Default Client Creator
   */
  static ClientCreator defaultClient;

  /**
   * Authentication Information
   */
  Authentication auth;

  /**
   * API Endpoint
   */
  final String endpoint;

  /**
   * HTTP Client
   */
  final http.Client client;



  HuntService _hunts;


  /**
   * Creates a new [PlayHunt] instance.
   *
   * [fetcher] is the HTTP Transporter to use
   * [endpoint] is the api endpoint to use
   * [auth] is the authentication information
   */
  PlayHunt({Authentication auth, this.endpoint: "http://162.248.167.159:8080/",
         http.Client client})
  : this.auth = auth == null ? new Authentication.anonymous() : auth,
    this.client = client == null ? defaultClient() : client;


  /// Service to explore GitHub.
  HuntService get hunts {
    if (_hunts == null) {
      _hunts = new HuntService(this);
    }
    return _hunts;
  }

  Future<dynamic> postJSON(String path, {int statusCode,
  void fail(http.Response response), Map<String, String> headers,
  Map<String, String> params, JSONConverter convert, body, String preview}) {
    if (headers == null) headers = {};

    if (preview != null) {
      headers["Accept"] = preview;
    }

    if (convert == null) {
      convert = (input) => input;
    }

    headers.putIfAbsent("Content-Type", () => "application/json; charset=utf-8");

    headers.putIfAbsent("Accept", () => "application/json; charset=utf-8");

    return request("POST", path, headers: headers, params: params, body: body,
    statusCode: statusCode, fail: fail)
    .then((response) {
      return convert(JSON.decode(response.body));
    });
  }

  /**
   * Handles Get Requests that respond with JSON
   *
   * [path] can either be a path like '/hunts' or a full url.
   *
   * [statusCode] is the expected status code. If it is null, it is ignored.
   * If the status code that the response returns is not the status code you provide
   * then the [fail] function will be called with the HTTP Response.
   * If you don't throw an error or break out somehow, it will go into some error checking
   * that throws exceptions when it finds a 404 or 401. If it doesn't find a general HTTP Status Code
   * for errors, it throws an Unknown Error.
   *
   * [headers] are HTTP Headers. If it doesn't exist, the 'Accept' and 'Authorization' headers are added.
   *
   * [params] are query string parameters.
   *
   * [convert] is a simple function that is passed this [PlayHunt] instance and a JSON object.
   * The future will pass the object returned from this function to the then method.
   * The default [convert] function returns the input object.
   */
  Future<dynamic> getJSON(String path, {int statusCode,
  void fail(http.Response response), Map<String, String> headers,
  Map<String, String> params, JSONConverter convert, String preview}) {
    if (headers == null) headers = {};

    if (preview != null) {
      headers["Accept"] = preview;
    }

    if (convert == null) {
      convert = (input) => input;
    }

    headers.putIfAbsent("Accept", () => "application/vnd.github.v3+json");

    return request("GET", path, headers: headers, params: params,
    statusCode: statusCode, fail: fail).then(
            (response) {
          return convert(JSON.decode(response.body));
        });
  }

  /**
   * Handles Authenticated Requests in an easy to understand way.
   *
   * [method] is the HTTP method.
   * [path] can either be a path like '/hunts' or a full url.
   * [headers] are HTTP Headers. If it doesn't exist, the 'Accept' and 'Authorization' headers are added.
   * [params] are query string parameters.
   * [body] is the body content of requests that take content.
   */
  Future<http.Response> request(String method, String path,
                                {Map<String, String> headers, Map<String, dynamic> params, String body,
                                int statusCode,
                                void fail(http.Response response), String preview}) {
    if (headers == null) headers = {};

    if (preview != null) {
      headers["Accept"] = preview;
    }

    if (auth.isToken) {
      headers.putIfAbsent("Authorization", () => "token ${auth.token}");
    } else if (auth.isBasic) {
      var userAndPass = utf8ToBase64('${auth.username}:${auth.password}');
      headers.putIfAbsent("Authorization", () => "basic ${userAndPass}");
    }

    if (method == "PUT" && body == null) {
      headers.putIfAbsent("Content-Length", () => "0");
    }

    var queryString = "";

    if (params != null) {
      queryString = buildQueryString(params);
    }

    var url = new StringBuffer();

    if (path.startsWith("http://") || path.startsWith("https://")) {
      url.write(path);
      url.write(queryString);
    } else {
      url.write(endpoint);
      url.write(path);
      url.write(queryString);
    }

    return client.request(new http.Request(url.toString(),
    method: method, headers: headers, body: body)).then((response) {
      if (statusCode != null && statusCode != response.statusCode) {
        fail != null ? fail(response) : null;
        handleStatusCode(response);
        return null;
      }
      else return response;
    });
  }


  /**
   * Internal method to handle status codes
   */
  void handleStatusCode(http.Response response) {
    switch (response.statusCode) {
      case 404:
        throw new NotFound(this, "Requested Resource was Not Found");
        break;
      case 401:
        throw new AccessForbidden(this);
      case 400:
        var json = response.asJSON();
        String msg = json['message'];
        if (msg == "Problems parsing JSON") {
          throw new InvalidJSON(this, msg);
        } else if (msg == "Body should be a JSON Hash") {
          throw new InvalidJSON(this, msg);
        }
        else throw new BadRequest(this);
        break;
      case 422:
        var json = response.asJSON();
        String msg = json['message'];
        var errors = json['errors'];

        var buff = new StringBuffer();
        buff.writeln();
        buff.writeln("  Message: ${msg}");

        if (errors != null) {
          buff.writeln("  Errors:");
          for (Map<String, String> error in errors) {
            var resource = error['resource'];
            var field = error['field'];
            var code = error['code'];
            buff
              ..writeln("    Resource: ${resource}")
              ..writeln("    Field ${field}")
              ..write("    Code: ${code}");
          }
        }
        throw new ValidationFailed(this, buff.toString());
    }
    throw new UnknownError(this);
  }


  /**
   * Disposes of this PlayHunt Instance.
   *
   * No other methods on this instance should be called after this method is called.
   */
  void dispose() {
    // Destroy the Authentication Information
    // This is needed for security reasons.
    auth = null;

    // Closes the HTTP Client
    client.close();
  }
}
