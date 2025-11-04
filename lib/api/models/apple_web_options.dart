class AppleWebOptions {
  const AppleWebOptions({
    required this.clientId,
    required this.redirectUri,
  });

  factory AppleWebOptions.fromJson(Map<String, dynamic> json) {
    return AppleWebOptions(
      clientId: json['clientId'] as String,
      redirectUri: json['redirectUri'] as String,
    );
  }

  final String clientId;
  final String redirectUri;

  AppleWebOptions copyWith({
    String? clientId,
    String? redirectUri,
  }) {
    return AppleWebOptions(
      clientId: clientId ?? this.clientId,
      redirectUri: redirectUri ?? this.redirectUri,
    );
  }
}
