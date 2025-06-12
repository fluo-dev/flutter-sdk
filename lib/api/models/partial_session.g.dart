// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartialSessionImpl _$$PartialSessionImplFromJson(Map<String, dynamic> json) =>
    _$PartialSessionImpl(
      id: json['id'] as String,
      email: json['email'] as String?,
      mobileE164: json['mobileE164'] as String?,
      mobileIso2: json['mobileIso2'] as String?,
      mobileLocal: json['mobileLocal'] as String?,
    );

Map<String, dynamic> _$$PartialSessionImplToJson(
        _$PartialSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'mobileE164': instance.mobileE164,
      'mobileIso2': instance.mobileIso2,
      'mobileLocal': instance.mobileLocal,
    };
