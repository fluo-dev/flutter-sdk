// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticationMethodImpl _$$AuthenticationMethodImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthenticationMethodImpl(
      id: json['id'] as String,
      selected: json['selected'] as bool,
      googleClientId: json['googleClientId'] == null
          ? null
          : GoogleClientId.fromJson(
              json['googleClientId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthenticationMethodImplToJson(
        _$AuthenticationMethodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'selected': instance.selected,
      'googleClientId': instance.googleClientId,
    };
