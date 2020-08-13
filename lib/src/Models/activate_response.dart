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

class ActivateResponse {
  ActivateResponse(this.userId, this.experimentKey, this.error);

  String userId;
  String experimentKey;
  String featureKey;
  String variationKey;
  String type;
  Map<String, dynamic> variables;
  bool enabled;
  String error;

  factory ActivateResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActivateResponseToJson(this);
}

ActivateResponse _$ActivateResponseFromJson(Map<String, dynamic> json) {
  return ActivateResponse(
    json['userId'] as String,
    json['experimentKey'] as String,
    json['error'] as String ?? '',
  )
    ..featureKey = json['featureKey'] as String
    ..variationKey = json['variationKey'] as String
    ..type = json['type'] as String
    ..variables = json['variables'] as Map<String, dynamic> ?? {}
    ..enabled = json['enabled'] as bool;
}

Map<String, dynamic> _$ActivateResponseToJson(ActivateResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'experimentKey': instance.experimentKey,
      'featureKey': instance.featureKey,
      'variationKey': instance.variationKey,
      'type': instance.type,
      'variables': instance.variables,
      'enabled': instance.enabled,
      'error': instance.error,
    };
