import 'package:fluo/api/models/auth_method.dart';
import 'package:fluo/api/models/registration_step.dart';

class AppConfig {
  const AppConfig({
    required this.termsUrl,
    required this.privacyUrl,
    required this.registrationSteps,
    required this.authMethods,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      termsUrl: json['termsUrl'] as String,
      privacyUrl: json['privacyUrl'] as String,
      registrationSteps: (json['registrationSteps'] as List<dynamic>)
          .map((e) => RegistrationStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      authMethods: (json['authMethods'] as List<dynamic>)
          .map((e) => AuthMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String termsUrl;
  final String privacyUrl;
  final List<RegistrationStep> registrationSteps;
  final List<AuthMethod> authMethods;

  AppConfig copyWith({
    String? termsUrl,
    String? privacyUrl,
    List<RegistrationStep>? registrationSteps,
    List<AuthMethod>? authMethods,
  }) {
    return AppConfig(
      termsUrl: termsUrl ?? this.termsUrl,
      privacyUrl: privacyUrl ?? this.privacyUrl,
      registrationSteps: registrationSteps ?? this.registrationSteps,
      authMethods: authMethods ?? this.authMethods,
    );
  }
}
