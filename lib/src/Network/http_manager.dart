import 'package:network/network.dart';

class HttpManager {
  final String _sdkKey;
  final String _url;
  NetworkClient _client;
  Map<String, String> _headers = {};

  HttpManager(this._sdkKey, this._url) {
    this._client = NetworkClient();
    _headers = {
      "X-Optimizely-SDK-Key": _sdkKey,
      "Content-Type": "application/json"
    };
  }

  Future<Response> getRequest(String endpoint) async {
    return await _client.get('$_url$endpoint', headers: _headers);
  }

  Future<Response> postRequest(String endpoint, Object body,
      [Map<String, String> queryParams]) async {
    if (queryParams != null) {
      return await _client.post('$_url$endpoint',
          headers: _headers, body: body, queryParameters: queryParams);
    } else {
      return await _client.post('$_url$endpoint',
          headers: _headers, body: body);
    }
  }
}
