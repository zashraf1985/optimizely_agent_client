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
import 'package:optimizely_agent_client/src/Models/decision_types.dart';

abstract class OptimizelyManager {
  Future<Response> getOptimizelyConfig();

  Future<Response> track(
      {@required String eventKey,
      String userId,
      Map<String, dynamic> eventTags,
      Map<String, dynamic> userAttributes});

  Future<Response> overrideDecision(
      {@required String userId,
      @required String experimentKey,
      @required String variationKey});

  Future<Response> activate({
    @required String userId,
    Map<String, dynamic> userAttributes,
    List<String> featureKey,
    List<String> experimentKey,
    bool disableTracking,
    decisionType type,
    bool enabled,
  });

  Future<Response> jwtToken({
    @required String grantType,
    @required String clientId,
    @required String clientSecret,
  });
}
