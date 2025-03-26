import 'package:fluo/api/models/google_client_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_method.freezed.dart';
part 'authentication_method.g.dart';

abstract class AuthenticationMethodId {
  static const String email = 'email';
  static const String google = 'google';
  static const String apple = 'apple';
}

@Freezed()
class AuthenticationMethod with _$AuthenticationMethod {
  const factory AuthenticationMethod({
    required String id,
    required bool selected,
    GoogleClientId? googleClientId,
  }) = _AuthenticationMethod;

  factory AuthenticationMethod.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationMethodFromJson(json);
}
