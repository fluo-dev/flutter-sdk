// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      id: json['id'] as String,
      accessToken: json['accessToken'] as String,
      expiresAt: (json['expiresAt'] as num).toInt(),
      refreshToken: json['refreshToken'] as String,
      userProfileComplete: json['userProfileComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accessToken': instance.accessToken,
      'expiresAt': instance.expiresAt,
      'refreshToken': instance.refreshToken,
    };
