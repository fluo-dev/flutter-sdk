import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../api/api_client.dart';
import '../api/models/session.dart';

class SessionManager {
  SessionManager._(Session? session) : _session = session;

  Session? _session;

  static Future<SessionManager> init() async {
    final session = await _readSession();
    return SessionManager._(session);
  }

  Future<Session?> getSession({
    required ApiClient apiClient,
    bool forceRefresh = false,
  }) async {
    var session = _session;
    if (session == null) {
      return null;
    }

    if (!forceRefresh && !_hasExpired(session.expiresAt)) {
      return session;
    }

    session = await apiClient.refreshToken(
      sessionId: session.id,
      refreshToken: session.refreshToken,
    );

    await _writeSession(session);

    _session = session;

    return session;
  }

  Future<void> setSession(Session session) async {
    await _writeSession(session);
    _session = session;
  }

  Future<void> clearSession() async {
    await _writeSession(null);
  }

  // Helpers

  static bool _hasExpired(int expirationEpochInSeconds) {
    return expirationEpochInSeconds < DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  // Secure storage for sensitive data

  static const _sessionKey = 'sessionKey';

  static Future<void> _writeSession(Session? session) async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: _sessionKey, value: session == null ? null : jsonEncode(session));
  }

  static Future<Session?> _readSession() async {
    const secureStorage = FlutterSecureStorage();
    final json = await secureStorage.read(key: _sessionKey);
    if (json == null) {
      return null;
    }
    return Session.fromJson(jsonDecode(json));
  }
}
