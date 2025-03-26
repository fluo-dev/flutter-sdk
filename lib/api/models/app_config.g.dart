// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppConfigImpl _$$AppConfigImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigImpl(
      termsUrl: json['termsUrl'] as String,
      privacyUrl: json['privacyUrl'] as String,
      registrationSteps: (json['registrationSteps'] as List<dynamic>)
          .map((e) => RegistrationStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      authMethods: (json['authMethods'] as List<dynamic>)
          .map((e) => AuthenticationMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AppConfigImplToJson(_$AppConfigImpl instance) =>
    <String, dynamic>{
      'termsUrl': instance.termsUrl,
      'privacyUrl': instance.privacyUrl,
      'registrationSteps': instance.registrationSteps,
      'authMethods': instance.authMethods,
    };
