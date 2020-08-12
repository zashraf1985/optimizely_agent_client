import 'package:optimizely_agent/client.dart';

export 'package:optimizely_agent/client.dart';
export 'package:optimizely_agent/src/Network/response_model.dart';

class OptimizelyFactory {
  String _sdkKey;
  String _url;

  OptimizelyFactory(this._sdkKey, this._url);

  OptimizelyClient client() {
    return OptimizelyClient(_sdkKey, _url);
  }
}
