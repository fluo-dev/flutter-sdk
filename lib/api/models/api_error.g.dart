// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiErrorImpl _$$ApiErrorImplFromJson(Map<String, dynamic> json) =>
    _$ApiErrorImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$$ApiErrorImplToJson(_$ApiErrorImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
