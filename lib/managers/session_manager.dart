import 'dart:convert';

import 'package:fluo/api/api_client.dart';
import 'package:fluo/api/models/api_error.dart';
import 'package:fluo/api/models/session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  SessionManager._(Session? session) : _session = session;

  Session? _session;

  Session? get session => _session;

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

    try {
      session = await apiClient.refreshSession(
        sessionId: session.id,
        refreshToken: session.refreshToken,
      );
    } on ApiError catch (_) {
      await clearSession();
      return null;
    }

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
    _session = null;
  }

  // Helpers

  static bool _hasExpired(int expEpochInSeconds) {
    return expEpochInSeconds < DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  // Secure storage for sensitive data

  static const _sessionKey = 'sessionKey';

  static Future<void> _writeSession(Session? session) async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(
      key: _sessionKey,
      value: session == null ? null : jsonEncode(session),
    );
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
