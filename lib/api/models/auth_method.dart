import 'package:fluo/api/models/apple_web_options.dart';
import 'package:fluo/api/models/google_client_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_method.freezed.dart';
part 'auth_method.g.dart';

abstract class AuthMethodId {
  static const String email = 'email';
  static const String mobile = 'mobile';
  static const String google = 'google';
  static const String apple = 'apple';
}

@Freezed()
class AuthMethod with _$AuthMethod {
  const factory AuthMethod({
    required String id,
    required bool selected,
    GoogleClientId? googleClientId,
    AppleWebOptions? appleWebOptions,
  }) = _AuthMethod;

  factory AuthMethod.fromJson(Map<String, dynamic> json) =>
      _$AuthMethodFromJson(json);
}
