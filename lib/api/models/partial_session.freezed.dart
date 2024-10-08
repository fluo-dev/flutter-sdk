// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partial_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartialSession _$PartialSessionFromJson(Map<String, dynamic> json) {
  return _PartialSession.fromJson(json);
}

/// @nodoc
mixin _$PartialSession {
  String get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Serializes this PartialSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartialSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartialSessionCopyWith<PartialSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartialSessionCopyWith<$Res> {
  factory $PartialSessionCopyWith(
          PartialSession value, $Res Function(PartialSession) then) =
      _$PartialSessionCopyWithImpl<$Res, PartialSession>;
  @useResult
  $Res call({String id, String? email});
}

/// @nodoc
class _$PartialSessionCopyWithImpl<$Res, $Val extends PartialSession>
    implements $PartialSessionCopyWith<$Res> {
  _$PartialSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartialSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartialSessionImplCopyWith<$Res>
    implements $PartialSessionCopyWith<$Res> {
  factory _$$PartialSessionImplCopyWith(_$PartialSessionImpl value,
          $Res Function(_$PartialSessionImpl) then) =
      __$$PartialSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? email});
}

/// @nodoc
class __$$PartialSessionImplCopyWithImpl<$Res>
    extends _$PartialSessionCopyWithImpl<$Res, _$PartialSessionImpl>
    implements _$$PartialSessionImplCopyWith<$Res> {
  __$$PartialSessionImplCopyWithImpl(
      _$PartialSessionImpl _value, $Res Function(_$PartialSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartialSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = freezed,
  }) {
    return _then(_$PartialSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartialSessionImpl implements _PartialSession {
  const _$PartialSessionImpl({required this.id, this.email});

  factory _$PartialSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartialSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String? email;

  @override
  String toString() {
    return 'PartialSession(id: $id, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartialSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, email);

  /// Create a copy of PartialSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartialSessionImplCopyWith<_$PartialSessionImpl> get copyWith =>
      __$$PartialSessionImplCopyWithImpl<_$PartialSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartialSessionImplToJson(
      this,
    );
  }
}

abstract class _PartialSession implements PartialSession {
  const factory _PartialSession(
      {required final String id, final String? email}) = _$PartialSessionImpl;

  factory _PartialSession.fromJson(Map<String, dynamic> json) =
      _$PartialSessionImpl.fromJson;

  @override
  String get id;
  @override
  String? get email;

  /// Create a copy of PartialSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartialSessionImplCopyWith<_$PartialSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
