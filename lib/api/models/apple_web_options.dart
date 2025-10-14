import 'package:freezed_annotation/freezed_annotation.dart';

part 'apple_web_options.freezed.dart';
part 'apple_web_options.g.dart';

@Freezed()
class AppleWebOptions with _$AppleWebOptions {
  const factory AppleWebOptions({
    required String clientId,
    required String redirectUri,
  }) = _AppleWebOptions;

  factory AppleWebOptions.fromJson(Map<String, dynamic> json) =>
      _$AppleWebOptionsFromJson(json);
}
