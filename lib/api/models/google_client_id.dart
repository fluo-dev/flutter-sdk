class GoogleClientId {
  const GoogleClientId({
    required this.ios,
    required this.android,
    required this.web,
  });

  factory GoogleClientId.fromJson(Map<String, dynamic> json) {
    return GoogleClientId(
      ios: json['ios'] as String,
      android: json['android'] as String,
      web: json['web'] as String,
    );
  }

  final String ios;
  final String android;
  final String web;

  GoogleClientId copyWith({
    String? ios,
    String? android,
    String? web,
  }) {
    return GoogleClientId(
      ios: ios ?? this.ios,
      android: android ?? this.android,
      web: web ?? this.web,
    );
  }
}
