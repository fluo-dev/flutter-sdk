import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_step.freezed.dart';
part 'registration_step.g.dart';

@Freezed()
class RegistrationStep with _$RegistrationStep {
  const factory RegistrationStep({
    required String id,
    required String fieldKey,
    required String path,
    required bool selected,
  }) = _RegistrationStep;

  factory RegistrationStep.fromJson(Map<String, dynamic> json) =>
      _$RegistrationStepFromJson(json);
}
