// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegistrationStep _$RegistrationStepFromJson(Map<String, dynamic> json) {
  return _RegistrationStep.fromJson(json);
}

/// @nodoc
mixin _$RegistrationStep {
  String get id => throw _privateConstructorUsedError;
  String get fieldKey => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  bool get selected => throw _privateConstructorUsedError;

  /// Serializes this RegistrationStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegistrationStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegistrationStepCopyWith<RegistrationStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationStepCopyWith<$Res> {
  factory $RegistrationStepCopyWith(
          RegistrationStep value, $Res Function(RegistrationStep) then) =
      _$RegistrationStepCopyWithImpl<$Res, RegistrationStep>;
  @useResult
  $Res call({String id, String fieldKey, String path, bool selected});
}

/// @nodoc
class _$RegistrationStepCopyWithImpl<$Res, $Val extends RegistrationStep>
    implements $RegistrationStepCopyWith<$Res> {
  _$RegistrationStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegistrationStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fieldKey = null,
    Object? path = null,
    Object? selected = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fieldKey: null == fieldKey
          ? _value.fieldKey
          : fieldKey // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegistrationStepImplCopyWith<$Res>
    implements $RegistrationStepCopyWith<$Res> {
  factory _$$RegistrationStepImplCopyWith(_$RegistrationStepImpl value,
          $Res Function(_$RegistrationStepImpl) then) =
      __$$RegistrationStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String fieldKey, String path, bool selected});
}

/// @nodoc
class __$$RegistrationStepImplCopyWithImpl<$Res>
    extends _$RegistrationStepCopyWithImpl<$Res, _$RegistrationStepImpl>
    implements _$$RegistrationStepImplCopyWith<$Res> {
  __$$RegistrationStepImplCopyWithImpl(_$RegistrationStepImpl _value,
      $Res Function(_$RegistrationStepImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fieldKey = null,
    Object? path = null,
    Object? selected = null,
  }) {
    return _then(_$RegistrationStepImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fieldKey: null == fieldKey
          ? _value.fieldKey
          : fieldKey // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegistrationStepImpl implements _RegistrationStep {
  const _$RegistrationStepImpl(
      {required this.id,
      required this.fieldKey,
      required this.path,
      required this.selected});

  factory _$RegistrationStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistrationStepImplFromJson(json);

  @override
  final String id;
  @override
  final String fieldKey;
  @override
  final String path;
  @override
  final bool selected;

  @override
  String toString() {
    return 'RegistrationStep(id: $id, fieldKey: $fieldKey, path: $path, selected: $selected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fieldKey, fieldKey) ||
                other.fieldKey == fieldKey) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, fieldKey, path, selected);

  /// Create a copy of RegistrationStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationStepImplCopyWith<_$RegistrationStepImpl> get copyWith =>
      __$$RegistrationStepImplCopyWithImpl<_$RegistrationStepImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistrationStepImplToJson(
      this,
    );
  }
}

abstract class _RegistrationStep implements RegistrationStep {
  const factory _RegistrationStep(
      {required final String id,
      required final String fieldKey,
      required final String path,
      required final bool selected}) = _$RegistrationStepImpl;

  factory _RegistrationStep.fromJson(Map<String, dynamic> json) =
      _$RegistrationStepImpl.fromJson;

  @override
  String get id;
  @override
  String get fieldKey;
  @override
  String get path;
  @override
  bool get selected;

  /// Create a copy of RegistrationStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegistrationStepImplCopyWith<_$RegistrationStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
