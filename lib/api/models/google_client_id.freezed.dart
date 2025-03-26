// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_client_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GoogleClientId _$GoogleClientIdFromJson(Map<String, dynamic> json) {
  return _GoogleClientId.fromJson(json);
}

/// @nodoc
mixin _$GoogleClientId {
  String get ios => throw _privateConstructorUsedError;
  String get android => throw _privateConstructorUsedError;
  String get web => throw _privateConstructorUsedError;

  /// Serializes this GoogleClientId to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoogleClientId
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoogleClientIdCopyWith<GoogleClientId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleClientIdCopyWith<$Res> {
  factory $GoogleClientIdCopyWith(
          GoogleClientId value, $Res Function(GoogleClientId) then) =
      _$GoogleClientIdCopyWithImpl<$Res, GoogleClientId>;
  @useResult
  $Res call({String ios, String android, String web});
}

/// @nodoc
class _$GoogleClientIdCopyWithImpl<$Res, $Val extends GoogleClientId>
    implements $GoogleClientIdCopyWith<$Res> {
  _$GoogleClientIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoogleClientId
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ios = null,
    Object? android = null,
    Object? web = null,
  }) {
    return _then(_value.copyWith(
      ios: null == ios
          ? _value.ios
          : ios // ignore: cast_nullable_to_non_nullable
              as String,
      android: null == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as String,
      web: null == web
          ? _value.web
          : web // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoogleClientIdImplCopyWith<$Res>
    implements $GoogleClientIdCopyWith<$Res> {
  factory _$$GoogleClientIdImplCopyWith(_$GoogleClientIdImpl value,
          $Res Function(_$GoogleClientIdImpl) then) =
      __$$GoogleClientIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ios, String android, String web});
}

/// @nodoc
class __$$GoogleClientIdImplCopyWithImpl<$Res>
    extends _$GoogleClientIdCopyWithImpl<$Res, _$GoogleClientIdImpl>
    implements _$$GoogleClientIdImplCopyWith<$Res> {
  __$$GoogleClientIdImplCopyWithImpl(
      _$GoogleClientIdImpl _value, $Res Function(_$GoogleClientIdImpl) _then)
      : super(_value, _then);

  /// Create a copy of GoogleClientId
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ios = null,
    Object? android = null,
    Object? web = null,
  }) {
    return _then(_$GoogleClientIdImpl(
      ios: null == ios
          ? _value.ios
          : ios // ignore: cast_nullable_to_non_nullable
              as String,
      android: null == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as String,
      web: null == web
          ? _value.web
          : web // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoogleClientIdImpl implements _GoogleClientId {
  const _$GoogleClientIdImpl(
      {required this.ios, required this.android, required this.web});

  factory _$GoogleClientIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoogleClientIdImplFromJson(json);

  @override
  final String ios;
  @override
  final String android;
  @override
  final String web;

  @override
  String toString() {
    return 'GoogleClientId(ios: $ios, android: $android, web: $web)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoogleClientIdImpl &&
            (identical(other.ios, ios) || other.ios == ios) &&
            (identical(other.android, android) || other.android == android) &&
            (identical(other.web, web) || other.web == web));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ios, android, web);

  /// Create a copy of GoogleClientId
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoogleClientIdImplCopyWith<_$GoogleClientIdImpl> get copyWith =>
      __$$GoogleClientIdImplCopyWithImpl<_$GoogleClientIdImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoogleClientIdImplToJson(
      this,
    );
  }
}

abstract class _GoogleClientId implements GoogleClientId {
  const factory _GoogleClientId(
      {required final String ios,
      required final String android,
      required final String web}) = _$GoogleClientIdImpl;

  factory _GoogleClientId.fromJson(Map<String, dynamic> json) =
      _$GoogleClientIdImpl.fromJson;

  @override
  String get ios;
  @override
  String get android;
  @override
  String get web;

  /// Create a copy of GoogleClientId
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoogleClientIdImplCopyWith<_$GoogleClientIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
