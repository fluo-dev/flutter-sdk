// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apple_web_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppleWebOptions _$AppleWebOptionsFromJson(Map<String, dynamic> json) {
  return _AppleWebOptions.fromJson(json);
}

/// @nodoc
mixin _$AppleWebOptions {
  String get clientId => throw _privateConstructorUsedError;
  String get redirectUri => throw _privateConstructorUsedError;

  /// Serializes this AppleWebOptions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppleWebOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppleWebOptionsCopyWith<AppleWebOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppleWebOptionsCopyWith<$Res> {
  factory $AppleWebOptionsCopyWith(
          AppleWebOptions value, $Res Function(AppleWebOptions) then) =
      _$AppleWebOptionsCopyWithImpl<$Res, AppleWebOptions>;
  @useResult
  $Res call({String clientId, String redirectUri});
}

/// @nodoc
class _$AppleWebOptionsCopyWithImpl<$Res, $Val extends AppleWebOptions>
    implements $AppleWebOptionsCopyWith<$Res> {
  _$AppleWebOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppleWebOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? redirectUri = null,
  }) {
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      redirectUri: null == redirectUri
          ? _value.redirectUri
          : redirectUri // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppleWebOptionsImplCopyWith<$Res>
    implements $AppleWebOptionsCopyWith<$Res> {
  factory _$$AppleWebOptionsImplCopyWith(_$AppleWebOptionsImpl value,
          $Res Function(_$AppleWebOptionsImpl) then) =
      __$$AppleWebOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String clientId, String redirectUri});
}

/// @nodoc
class __$$AppleWebOptionsImplCopyWithImpl<$Res>
    extends _$AppleWebOptionsCopyWithImpl<$Res, _$AppleWebOptionsImpl>
    implements _$$AppleWebOptionsImplCopyWith<$Res> {
  __$$AppleWebOptionsImplCopyWithImpl(
      _$AppleWebOptionsImpl _value, $Res Function(_$AppleWebOptionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppleWebOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? redirectUri = null,
  }) {
    return _then(_$AppleWebOptionsImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      redirectUri: null == redirectUri
          ? _value.redirectUri
          : redirectUri // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppleWebOptionsImpl implements _AppleWebOptions {
  const _$AppleWebOptionsImpl(
      {required this.clientId, required this.redirectUri});

  factory _$AppleWebOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppleWebOptionsImplFromJson(json);

  @override
  final String clientId;
  @override
  final String redirectUri;

  @override
  String toString() {
    return 'AppleWebOptions(clientId: $clientId, redirectUri: $redirectUri)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppleWebOptionsImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.redirectUri, redirectUri) ||
                other.redirectUri == redirectUri));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, clientId, redirectUri);

  /// Create a copy of AppleWebOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppleWebOptionsImplCopyWith<_$AppleWebOptionsImpl> get copyWith =>
      __$$AppleWebOptionsImplCopyWithImpl<_$AppleWebOptionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppleWebOptionsImplToJson(
      this,
    );
  }
}

abstract class _AppleWebOptions implements AppleWebOptions {
  const factory _AppleWebOptions(
      {required final String clientId,
      required final String redirectUri}) = _$AppleWebOptionsImpl;

  factory _AppleWebOptions.fromJson(Map<String, dynamic> json) =
      _$AppleWebOptionsImpl.fromJson;

  @override
  String get clientId;
  @override
  String get redirectUri;

  /// Create a copy of AppleWebOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppleWebOptionsImplCopyWith<_$AppleWebOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
