import 'package:freezed_annotation/freezed_annotation.dart';

part 'partial_session.freezed.dart';
part 'partial_session.g.dart';

@Freezed()
class PartialSession with _$PartialSession {
  const factory PartialSession({
    required String id,
    String? email,
    String? mobileE164,
    String? mobileIso2,
    String? mobileLocal,
  }) = _PartialSession;

  factory PartialSession.fromJson(Map<String, dynamic> json) =>
      _$PartialSessionFromJson(json);
}
