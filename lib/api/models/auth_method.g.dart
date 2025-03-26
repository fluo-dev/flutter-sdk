// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthMethodImpl _$$AuthMethodImplFromJson(Map<String, dynamic> json) =>
    _$AuthMethodImpl(
      id: json['id'] as String,
      selected: json['selected'] as bool,
      googleClientId: json['googleClientId'] == null
          ? null
          : GoogleClientId.fromJson(
              json['googleClientId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthMethodImplToJson(_$AuthMethodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'selected': instance.selected,
      'googleClientId': instance.googleClientId,
    };
