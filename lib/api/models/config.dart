import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@Freezed()
class Config with _$Config {
  const factory Config({
    required String termsUrl,
    required String privacyUrl,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
