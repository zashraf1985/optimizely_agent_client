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

class TrackResponse {
  TrackResponse(this.userId, this.eventKey, this.error);

  String userId;
  String eventKey;
  String error;

  factory TrackResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrackResponseToJson(this);
}

TrackResponse _$TrackResponseFromJson(Map<String, dynamic> json) {
  return TrackResponse(
    json['userId'] as String,
    json['eventKey'] as String,
    json['error'] as String ?? '',
  );
}

Map<String, dynamic> _$TrackResponseToJson(TrackResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'eventKey': instance.eventKey,
      'error': instance.error,
    };
