import 'package:fluo/api/models/user.dart';

class Session {
  const Session({
    required this.id,
    required this.accessToken,
    required this.expiresAt,
    required this.refreshToken,
    this.firebaseToken,
    this.supabaseToken,
    this.supabaseSession,
    required this.user,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as String,
      accessToken: json['accessToken'] as String,
      expiresAt: json['expiresAt'] as int,
      refreshToken: json['refreshToken'] as String,
      firebaseToken: json['firebaseToken'] as String?,
      supabaseToken: json['supabaseToken'] as String?,
      supabaseSession: json['supabaseSession'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  final String id;
  final String accessToken;
  final int expiresAt;
  final String refreshToken;
  final String? firebaseToken;
  final String? supabaseToken;
  final String? supabaseSession;
  final User user;

  Session copyWith({
    String? id,
    String? accessToken,
    int? expiresAt,
    String? refreshToken,
    String? firebaseToken,
    String? supabaseToken,
    String? supabaseSession,
    User? user,
  }) {
    return Session(
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      expiresAt: expiresAt ?? this.expiresAt,
      refreshToken: refreshToken ?? this.refreshToken,
      firebaseToken: firebaseToken ?? this.firebaseToken,
      supabaseToken: supabaseToken ?? this.supabaseToken,
      supabaseSession: supabaseSession ?? this.supabaseSession,
      user: user ?? this.user,
    );
  }
}
