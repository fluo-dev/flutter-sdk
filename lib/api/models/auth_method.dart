import 'package:fluo/api/models/apple_web_options.dart';
import 'package:fluo/api/models/google_client_id.dart';

abstract class AuthMethodId {
  static const String email = 'email';
  static const String mobile = 'mobile';
  static const String google = 'google';
  static const String apple = 'apple';
}

class AuthMethod {
  const AuthMethod({
    required this.id,
    required this.selected,
    this.googleClientId,
    this.appleWebOptions,
  });

  factory AuthMethod.fromJson(Map<String, dynamic> json) {
    return AuthMethod(
      id: json['id'] as String,
      selected: json['selected'] as bool,
      googleClientId: json['googleClientId'] != null
          ? GoogleClientId.fromJson(
              json['googleClientId'] as Map<String, dynamic>)
          : null,
      appleWebOptions: json['appleWebOptions'] != null
          ? AppleWebOptions.fromJson(
              json['appleWebOptions'] as Map<String, dynamic>)
          : null,
    );
  }

  final String id;
  final bool selected;
  final GoogleClientId? googleClientId;
  final AppleWebOptions? appleWebOptions;

  AuthMethod copyWith({
    String? id,
    bool? selected,
    GoogleClientId? googleClientId,
    AppleWebOptions? appleWebOptions,
  }) {
    return AuthMethod(
      id: id ?? this.id,
      selected: selected ?? this.selected,
      googleClientId: googleClientId ?? this.googleClientId,
      appleWebOptions: appleWebOptions ?? this.appleWebOptions,
    );
  }
}
