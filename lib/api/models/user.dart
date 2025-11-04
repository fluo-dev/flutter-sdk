class User {
  const User({
    required this.id,
    this.email,
    this.mobileE164,
    this.mobileIso2,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String?,
      mobileE164: json['mobileE164'] as String?,
      mobileIso2: json['mobileIso2'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );
  }

  final String id;
  final String? email;
  final String? mobileE164;
  final String? mobileIso2;
  final String? firstName;
  final String? lastName;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'mobileE164': mobileE164,
      'mobileIso2': mobileIso2,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? mobileE164,
    String? mobileIso2,
    String? firstName,
    String? lastName,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      mobileE164: mobileE164 ?? this.mobileE164,
      mobileIso2: mobileIso2 ?? this.mobileIso2,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
