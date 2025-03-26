import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_client_id.freezed.dart';
part 'google_client_id.g.dart';

@Freezed()
class GoogleClientId with _$GoogleClientId {
  const factory GoogleClientId({
    required String ios,
    required String android,
    required String web,
  }) = _GoogleClientId;

  factory GoogleClientId.fromJson(Map<String, dynamic> json) =>
      _$GoogleClientIdFromJson(json);
}
