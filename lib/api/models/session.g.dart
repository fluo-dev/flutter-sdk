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
      firebaseToken: json['firebaseToken'] as String?,
      supabaseToken: json['supabaseToken'] as String?,
      supabaseSession: json['supabaseSession'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accessToken': instance.accessToken,
      'expiresAt': instance.expiresAt,
      'refreshToken': instance.refreshToken,
      'firebaseToken': instance.firebaseToken,
      'supabaseToken': instance.supabaseToken,
      'supabaseSession': instance.supabaseSession,
      'user': instance.user,
    };
