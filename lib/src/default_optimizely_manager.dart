/****************************************************************************
 * Copyright 2020, Optimizely, Inc. and contributors                        *
 *                                                                          *
 * Licensed under the Apache License, Version 2.0 (the "License");          *
 * you may not use this file except in compliance with the License.         *
 * You may obtain a copy of the License at                                  *
 *                                                                          *
 *    http://www.apache.org/licenses/LICENSE-2.0                            *
 *                                                                          *
 * Unless required by applicable law or agreed to in writing, software      *
 * distributed under the License is distributed on an "AS IS" BASIS,        *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *
 * See the License for the specific language governing permissions and      *
 * limitations under the License.                                           *
 ***************************************************************************/

import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:optimizely_agent_client/src/Interfaces/optimizely_manager.dart';
import 'package:optimizely_agent_client/src/Models/decision_types.dart';
import 'package:optimizely_agent_client/src/Network/http_manager.dart';

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
  Future<Response> track(
      {@required String eventKey,
      String userId,
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
      {@required String userId,
      @required String experimentKey,
      @required String variationKey}) async {
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

  @override
  Future<Response> activate({
    @required String userId,
    Map<String, dynamic> userAttributes,
    List<String> featureKey,
    List<String> experimentKey,
    bool disableTracking,
    decisionType type,
    bool enabled,
  }) async {
    Map<String, dynamic> body = {"userId": userId};
    if (userAttributes != null) {
      body["userAttributes"] = userAttributes;
    }

    Map<String, String> queryParams = {};
    if (featureKey != null) {
      queryParams["featureKey"] = featureKey.join(',');
    }
    if (experimentKey != null) {
      queryParams["experimentKey"] = experimentKey.join(',');
    }
    if (disableTracking != null) {
      queryParams["disableTracking"] = disableTracking.toString();
    }
    if (type != null) {
      queryParams["type"] = type.toString().split('.').last;
    }
    if (enabled != null) {
      queryParams["enabled"] = enabled.toString();
    }
    Response resp;
    await _manager
        .postRequest("/v1/activate", body, queryParams)
        .then((value) => resp = value);
    return resp;
  }

  @override
  Future<Response> jwtToken(
      {@required String grantType,
      @required String clientId,
      @required String clientSecret}) async {
    Map<String, dynamic> body = {
      "grant_type": grantType,
      "client_id": clientId,
      "client_secret": clientSecret
    };
    Response resp;
    await _manager
        .postRequest("/oauth/token", body)
        .then((value) => resp = value);
    return resp;
  }
}
