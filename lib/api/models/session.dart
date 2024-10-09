import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@Freezed()
class Session with _$Session {
  const factory Session({
    required String id,
    required String accessToken,
    required int expiresAt,
    required String refreshToken,
    required bool userProfileComplete,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
