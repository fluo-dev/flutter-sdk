// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthenticationMethod _$AuthenticationMethodFromJson(Map<String, dynamic> json) {
  return _AuthenticationMethod.fromJson(json);
}

/// @nodoc
mixin _$AuthenticationMethod {
  String get id => throw _privateConstructorUsedError;
  bool get selected => throw _privateConstructorUsedError;
  GoogleClientId? get googleClientId => throw _privateConstructorUsedError;

  /// Serializes this AuthenticationMethod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthenticationMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthenticationMethodCopyWith<AuthenticationMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationMethodCopyWith<$Res> {
  factory $AuthenticationMethodCopyWith(AuthenticationMethod value,
          $Res Function(AuthenticationMethod) then) =
      _$AuthenticationMethodCopyWithImpl<$Res, AuthenticationMethod>;
  @useResult
  $Res call({String id, bool selected, GoogleClientId? googleClientId});

  $GoogleClientIdCopyWith<$Res>? get googleClientId;
}

/// @nodoc
class _$AuthenticationMethodCopyWithImpl<$Res,
        $Val extends AuthenticationMethod>
    implements $AuthenticationMethodCopyWith<$Res> {
  _$AuthenticationMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? selected = null,
    Object? googleClientId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      googleClientId: freezed == googleClientId
          ? _value.googleClientId
          : googleClientId // ignore: cast_nullable_to_non_nullable
              as GoogleClientId?,
    ) as $Val);
  }

  /// Create a copy of AuthenticationMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoogleClientIdCopyWith<$Res>? get googleClientId {
    if (_value.googleClientId == null) {
      return null;
    }

    return $GoogleClientIdCopyWith<$Res>(_value.googleClientId!, (value) {
      return _then(_value.copyWith(googleClientId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthenticationMethodImplCopyWith<$Res>
    implements $AuthenticationMethodCopyWith<$Res> {
  factory _$$AuthenticationMethodImplCopyWith(_$AuthenticationMethodImpl value,
          $Res Function(_$AuthenticationMethodImpl) then) =
      __$$AuthenticationMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, bool selected, GoogleClientId? googleClientId});

  @override
  $GoogleClientIdCopyWith<$Res>? get googleClientId;
}

/// @nodoc
class __$$AuthenticationMethodImplCopyWithImpl<$Res>
    extends _$AuthenticationMethodCopyWithImpl<$Res, _$AuthenticationMethodImpl>
    implements _$$AuthenticationMethodImplCopyWith<$Res> {
  __$$AuthenticationMethodImplCopyWithImpl(_$AuthenticationMethodImpl _value,
      $Res Function(_$AuthenticationMethodImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? selected = null,
    Object? googleClientId = freezed,
  }) {
    return _then(_$AuthenticationMethodImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      googleClientId: freezed == googleClientId
          ? _value.googleClientId
          : googleClientId // ignore: cast_nullable_to_non_nullable
              as GoogleClientId?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthenticationMethodImpl implements _AuthenticationMethod {
  const _$AuthenticationMethodImpl(
      {required this.id, required this.selected, this.googleClientId});

  factory _$AuthenticationMethodImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthenticationMethodImplFromJson(json);

  @override
  final String id;
  @override
  final bool selected;
  @override
  final GoogleClientId? googleClientId;

  @override
  String toString() {
    return 'AuthenticationMethod(id: $id, selected: $selected, googleClientId: $googleClientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationMethodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.googleClientId, googleClientId) ||
                other.googleClientId == googleClientId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, selected, googleClientId);

  /// Create a copy of AuthenticationMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationMethodImplCopyWith<_$AuthenticationMethodImpl>
      get copyWith =>
          __$$AuthenticationMethodImplCopyWithImpl<_$AuthenticationMethodImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthenticationMethodImplToJson(
      this,
    );
  }
}

abstract class _AuthenticationMethod implements AuthenticationMethod {
  const factory _AuthenticationMethod(
      {required final String id,
      required final bool selected,
      final GoogleClientId? googleClientId}) = _$AuthenticationMethodImpl;

  factory _AuthenticationMethod.fromJson(Map<String, dynamic> json) =
      _$AuthenticationMethodImpl.fromJson;

  @override
  String get id;
  @override
  bool get selected;
  @override
  GoogleClientId? get googleClientId;

  /// Create a copy of AuthenticationMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationMethodImplCopyWith<_$AuthenticationMethodImpl>
      get copyWith => throw _privateConstructorUsedError;
}
