import 'dart:io';

import 'package:dio/dio.dart';

class HttpManager {
  final String _sdkKey;
  final String _url;
  final _client = Dio();

  HttpManager(this._sdkKey, this._url) {
    _client.options.baseUrl = _url;
    _client.options.headers = {
      "X-Optimizely-SDK-Key": _sdkKey,
      HttpHeaders.contentTypeHeader: "application/json"
    };
  }

  Future<Response> getRequest(String endpoint) async {
    return await _client.get('$_url$endpoint');
  }

  Future<Response> postRequest(String endpoint, Object body,
      [Map<String, String> queryParams]) async {
    return await _client.post(endpoint,
        data: body, queryParameters: queryParams);
  }
}
