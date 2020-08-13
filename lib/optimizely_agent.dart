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
import 'package:optimizely_agent_client/src/Models/activate_response.dart';
import 'package:optimizely_agent_client/src/Models/decision_types.dart';

import 'package:dio/dio.dart';
import 'package:optimizely_agent_client/src/Models/optimizely_config/optimizely_config.dart';
import 'package:optimizely_agent_client/src/Models/override_response.dart';
import 'package:optimizely_agent_client/src/Models/token_response.dart';
import 'package:optimizely_agent_client/src/Models/track_response.dart';
import 'package:optimizely_agent_client/src/request_manager.dart';
import 'package:tuple/tuple.dart';

export 'package:optimizely_agent_client/src/Models/decision_types.dart';
export 'package:optimizely_agent_client/src/Models/optimizely_config/optimizely_config.dart';
export 'package:optimizely_agent_client/src/Models/activate_response.dart';
export 'package:optimizely_agent_client/src/Models/override_response.dart';
export 'package:optimizely_agent_client/src/Models/token_response.dart';
export 'package:optimizely_agent_client/src/Models/track_response.dart';

class OptimizelyAgent {
  RequestManager _manager;

  OptimizelyAgent(String sdkKey, String url) {
    _manager = RequestManager(sdkKey, url);
  }

  Future<Tuple2<int, OptimizelyConfig>> getOptimizelyConfig() async {
    Response resp = await _manager.getOptimizelyConfig();

    if (resp.statusCode == 200) {
      var optConfig = OptimizelyConfig.fromJson(resp.data);
      return Tuple2(resp.statusCode, optConfig);
    }
    return Tuple2(resp.statusCode, null);
  }

  Future<Tuple2<int, TrackResponse>> track(
      {@required String eventKey,
      String userId,
      Map<String, dynamic> eventTags,
      Map<String, dynamic> userAttributes}) async {
    Response resp = await _manager.track(
        eventKey: eventKey,
        userId: userId,
        eventTags: eventTags,
        userAttributes: userAttributes);
    if (resp.statusCode == 200) {
      var trackResponse = TrackResponse.fromJson(resp.data);
      return Tuple2(resp.statusCode, trackResponse);
    }
    return Tuple2(resp.statusCode, null);
  }

  Future<Tuple2<int, OverrideResponse>> overrideDecision(
      {@required String userId,
      @required String experimentKey,
      @required String variationKey}) async {
    Response resp = await _manager.overrideDecision(
        userId: userId,
        experimentKey: experimentKey,
        variationKey: variationKey);

    if (resp.statusCode == 200) {
      var overrideResponse = OverrideResponse.fromJson(resp.data);
      return Tuple2(resp.statusCode, overrideResponse);
    }
    return Tuple2(resp.statusCode, null);
  }

  Future<Tuple2<int, List<ActivateResponse>>> activate(
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
    if (resp.statusCode == 200) {
      List<dynamic> decisions = resp.data;
      List<ActivateResponse> convertedDecisions = [];
      decisions.forEach((element) {
        convertedDecisions.add(ActivateResponse.fromJson(element));
      });
      return Tuple2(resp.statusCode, convertedDecisions);
    }
    return Tuple2(resp.statusCode, null);
  }

  Future<Tuple2<int, TokenResponse>> jwtToken(
      {@required String grantType,
      @required String clientId,
      @required String clientSecret}) async {
    Response resp = await _manager.jwtToken(
      grantType: grantType,
      clientId: clientId,
      clientSecret: clientSecret,
    );
    if (resp.statusCode == 200) {
      var overrideResponse = TokenResponse.fromJson(resp.data);
      return Tuple2(resp.statusCode, overrideResponse);
    }
    return Tuple2(resp.statusCode, null);
  }
}
