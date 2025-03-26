import 'package:fluo/api/models/auth_method.dart';
import 'package:fluo/api/models/registration_step.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

@Freezed()
class AppConfig with _$AppConfig {
  const factory AppConfig({
    required String termsUrl,
    required String privacyUrl,
    required List<RegistrationStep> registrationSteps,
    required List<AuthMethod> authMethods,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}
