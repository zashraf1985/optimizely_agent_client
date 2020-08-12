import 'package:network/network.dart';
import 'package:optimizely_agent/decision_types.dart';
import 'package:optimizely_agent/src/Network/http_manager.dart';

abstract class OptimizelyManager {
  Future<Response> getOptimizelyConfig();

  Future<Response> track(String eventKey,
      {String userId,
      Map<String, dynamic> eventTags,
      Map<String, dynamic> userAttributes});

  Future<Response> overrideDecision(
      String userId, String experimentKey, String variationKey);

  // Future<Response> activate(
  //   String userId, {
  //   Map<String, dynamic> userAttributes,
  //   List<String> featureKey,
  //   List<String> experimentKey,
  //   bool disableTracking,
  //   decisionType type,
  //   bool enabled,
  // });
}

class DefaultOptimizelyManager extends OptimizelyManager {
  HttpManager _manager;

  DefaultOptimizelyManager(String sdkKey, url) {
    _manager = HttpManager(sdkKey, url);
  }

  @override
  Future<Response> getOptimizelyConfig() async {
    Response resp;
    await _manager.getRequest("/v1/config").then((value) => resp = value);
    return resp;
  }

  @override
  Future<Response> track(String eventKey,
      {String userId,
      Map<String, dynamic> eventTags,
      Map<String, dynamic> userAttributes}) async {
    Map<String, dynamic> body = {};
    if (userId != null) {
      body["userId"] = userId;
    }
    if (eventTags != null) {
      body["eventTags"] = eventTags;
    }
    if (userAttributes != null) {
      body["userAttributes"] = userAttributes;
    }

    Response resp;
    await _manager.postRequest("/v1/track", body, {"eventKey": eventKey}).then(
        (value) => resp = value);
    return resp;
  }

  @override
  Future<Response> overrideDecision(
      String userId, String experimentKey, String variationKey) async {
    Map<String, dynamic> body = {
      "userId": userId,
      "experimentKey": experimentKey,
      "variationKey": variationKey
    };
    Response resp;
    await _manager
        .postRequest("/v1/override", body)
        .then((value) => resp = value);
    return resp;
  }

  // @override
  // Future<Response> activate(String userId,
  //     {Map<String, dynamic> userAttributes,
  //     List<String> featureKey,
  //     List<String> experimentKey,
  //     bool disableTracking,
  //     decisionType type,
  //     bool enabled}) async {
  //   Map<String, dynamic> body = {"userId": userId};
  //   if (userAttributes != null) {
  //     body["userAttributes"] = userAttributes;
  //   }
  //   Response resp;
  //   await _manager
  //       .postRequest("/v1/act", body)
  //       .then((value) => resp = value);
  //   return resp;
  // }
}
