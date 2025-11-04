class PartialSession {
  const PartialSession({
    required this.id,
    this.email,
    this.mobileE164,
    this.mobileIso2,
    this.mobileLocal,
  });

  factory PartialSession.fromJson(Map<String, dynamic> json) {
    return PartialSession(
      id: json['id'] as String,
      email: json['email'] as String?,
      mobileE164: json['mobileE164'] as String?,
      mobileIso2: json['mobileIso2'] as String?,
      mobileLocal: json['mobileLocal'] as String?,
    );
  }

  final String id;
  final String? email;
  final String? mobileE164;
  final String? mobileIso2;
  final String? mobileLocal;

  PartialSession copyWith({
    String? id,
    String? email,
    String? mobileE164,
    String? mobileIso2,
    String? mobileLocal,
  }) {
    return PartialSession(
      id: id ?? this.id,
      email: email ?? this.email,
      mobileE164: mobileE164 ?? this.mobileE164,
      mobileIso2: mobileIso2 ?? this.mobileIso2,
      mobileLocal: mobileLocal ?? this.mobileLocal,
    );
  }
}
