import 'package:optimizely_agent/src/Network/optimizely_manager.dart';
import 'package:optimizely_agent/src/Network/response_model.dart'
    as ResponseModel;
import 'package:network/network.dart';

class OptimizelyClient {
  OptimizelyManager _manager;

  OptimizelyClient(String sdkKey, String url) {
    _manager = DefaultOptimizelyManager(sdkKey, url);
  }

  Future<ResponseModel.Response> getOptimizelyConfig() async {
    Response resp = await _manager.getOptimizelyConfig();
    return ResponseModel.Response(
        resp.statusCode, resp.statusCode == 200 ? resp.asMap : resp);
  }

  Future<ResponseModel.Response> track(String eventKey,
      {String userId,
      Map<String, dynamic> eventTags,
      Map<String, dynamic> userAttributes}) async {
    Response resp = await _manager.track(eventKey,
        userId: userId, eventTags: eventTags, userAttributes: userAttributes);
    return ResponseModel.Response(
        resp.statusCode, resp.statusCode == 200 ? resp.asMap : resp);
  }

  Future<ResponseModel.Response> overrideDecision(
      String userId, String experimentKey, String variationKey) async {
    Response resp =
        await _manager.overrideDecision(userId, experimentKey, variationKey);
    return ResponseModel.Response(
        resp.statusCode, resp.statusCode == 200 ? resp.asMap : resp);
  }
}
