// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthMethod _$AuthMethodFromJson(Map<String, dynamic> json) {
  return _AuthMethod.fromJson(json);
}

/// @nodoc
mixin _$AuthMethod {
  String get id => throw _privateConstructorUsedError;
  bool get selected => throw _privateConstructorUsedError;
  GoogleClientId? get googleClientId => throw _privateConstructorUsedError;

  /// Serializes this AuthMethod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthMethodCopyWith<AuthMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthMethodCopyWith<$Res> {
  factory $AuthMethodCopyWith(
          AuthMethod value, $Res Function(AuthMethod) then) =
      _$AuthMethodCopyWithImpl<$Res, AuthMethod>;
  @useResult
  $Res call({String id, bool selected, GoogleClientId? googleClientId});

  $GoogleClientIdCopyWith<$Res>? get googleClientId;
}

/// @nodoc
class _$AuthMethodCopyWithImpl<$Res, $Val extends AuthMethod>
    implements $AuthMethodCopyWith<$Res> {
  _$AuthMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthMethod
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

  /// Create a copy of AuthMethod
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
abstract class _$$AuthMethodImplCopyWith<$Res>
    implements $AuthMethodCopyWith<$Res> {
  factory _$$AuthMethodImplCopyWith(
          _$AuthMethodImpl value, $Res Function(_$AuthMethodImpl) then) =
      __$$AuthMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, bool selected, GoogleClientId? googleClientId});

  @override
  $GoogleClientIdCopyWith<$Res>? get googleClientId;
}

/// @nodoc
class __$$AuthMethodImplCopyWithImpl<$Res>
    extends _$AuthMethodCopyWithImpl<$Res, _$AuthMethodImpl>
    implements _$$AuthMethodImplCopyWith<$Res> {
  __$$AuthMethodImplCopyWithImpl(
      _$AuthMethodImpl _value, $Res Function(_$AuthMethodImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? selected = null,
    Object? googleClientId = freezed,
  }) {
    return _then(_$AuthMethodImpl(
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
class _$AuthMethodImpl implements _AuthMethod {
  const _$AuthMethodImpl(
      {required this.id, required this.selected, this.googleClientId});

  factory _$AuthMethodImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthMethodImplFromJson(json);

  @override
  final String id;
  @override
  final bool selected;
  @override
  final GoogleClientId? googleClientId;

  @override
  String toString() {
    return 'AuthMethod(id: $id, selected: $selected, googleClientId: $googleClientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthMethodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.googleClientId, googleClientId) ||
                other.googleClientId == googleClientId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, selected, googleClientId);

  /// Create a copy of AuthMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthMethodImplCopyWith<_$AuthMethodImpl> get copyWith =>
      __$$AuthMethodImplCopyWithImpl<_$AuthMethodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthMethodImplToJson(
      this,
    );
  }
}

abstract class _AuthMethod implements AuthMethod {
  const factory _AuthMethod(
      {required final String id,
      required final bool selected,
      final GoogleClientId? googleClientId}) = _$AuthMethodImpl;

  factory _AuthMethod.fromJson(Map<String, dynamic> json) =
      _$AuthMethodImpl.fromJson;

  @override
  String get id;
  @override
  bool get selected;
  @override
  GoogleClientId? get googleClientId;

  /// Create a copy of AuthMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthMethodImplCopyWith<_$AuthMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
