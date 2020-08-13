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
import 'package:optimizely_agent_client/src/Models/decision_types.dart';
import 'package:optimizely_agent_client/src/Interfaces/optimizely_manager.dart';
import 'package:optimizely_agent_client/src/Models/response_model.dart'
    as ResponseModel;
import 'package:dio/dio.dart';
import 'package:optimizely_agent_client/src/default_optimizely_manager.dart';

export 'package:optimizely_agent_client/src/Models/response_model.dart';
export 'package:optimizely_agent_client/src/Models/decision_types.dart';

class OptimizelyAgent {
  OptimizelyManager _manager;

  OptimizelyAgent(String sdkKey, String url) {
    _manager = DefaultOptimizelyManager(sdkKey, url);
  }

  Future<ResponseModel.Response> getOptimizelyConfig() async {
    Response resp = await _manager.getOptimizelyConfig();
    return ResponseModel.Response(resp.statusCode, resp.data);
  }

  Future<ResponseModel.Response> track(
      {@required String eventKey,
      String userId,
      Map<String, dynamic> eventTags,
      Map<String, dynamic> userAttributes}) async {
    Response resp = await _manager.track(
        eventKey: eventKey,
        userId: userId,
        eventTags: eventTags,
        userAttributes: userAttributes);
    return ResponseModel.Response(resp.statusCode, resp.data);
  }

  Future<ResponseModel.Response> overrideDecision(
      {@required String userId,
      @required String experimentKey,
      @required String variationKey}) async {
    Response resp = await _manager.overrideDecision(
        userId: userId,
        experimentKey: experimentKey,
        variationKey: variationKey);
    return ResponseModel.Response(resp.statusCode, resp.data);
  }

  Future<ResponseModel.Response> activate(
      {@required String userId,
      Map<String, dynamic> userAttributes,
      List<String> featureKey,
      List<String> experimentKey,
      bool disableTracking,
      decisionType type,
      bool enabled}) async {
    Response resp = await _manager.activate(
        userId: userId,
        userAttributes: userAttributes,
        featureKey: featureKey,
        experimentKey: experimentKey,
        disableTracking: disableTracking,
        type: type,
        enabled: enabled);
    return ResponseModel.Response(resp.statusCode, resp.data);
  }

  Future<ResponseModel.Response> jwtToken(
      {@required String grantType,
      @required String clientId,
      @required String clientSecret}) async {
    Response resp = await _manager.jwtToken(
      grantType: grantType,
      clientId: clientId,
      clientSecret: clientSecret,
    );
    return ResponseModel.Response(resp.statusCode, resp.data);
  }
}
