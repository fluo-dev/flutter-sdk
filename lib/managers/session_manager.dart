import 'dart:convert';

import 'package:fluo/api/api_client.dart';
import 'package:fluo/api/models/api_error.dart';
import 'package:fluo/api/models/session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  SessionManager._(this._session, this._prefs);

  Session? _session;

  final SharedPreferences? _prefs;

  static final _secureStorage = FlutterSecureStorage();

  Session? get session => _session;

  static Future<SessionManager> init({
    bool useSecureStorage = true,
  }) async {
    SharedPreferences? prefs;
    if (!useSecureStorage) {
      prefs = await SharedPreferences.getInstance();
    }

    final session = await _readSessionFromLocalStorage(prefs);

    return SessionManager._(session, prefs);
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

    await _writeSessionToLocalStorage(session, _prefs);

    _session = session;

    return session;
  }

  Future<void> setSession(Session session) async {
    await _writeSessionToLocalStorage(session, _prefs);
    _session = session;
  }

  Future<void> clearSession() async {
    await _deleteSessionFromLocalStorage(_prefs);
    _session = null;
  }

  // Helpers

  static bool _hasExpired(int expEpochInSeconds) {
    return expEpochInSeconds < DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  // Secure storage for sensitive data

  static const _sessionKey = 'sessionKey';

  static Future<void> _writeSessionToLocalStorage(
    Session session,
    SharedPreferences? prefs,
  ) async {
    final sessionJson = jsonEncode(session);
    if (prefs != null) {
      await prefs.setString(_sessionKey, sessionJson);
    } else {
      await _secureStorage.write(key: _sessionKey, value: sessionJson);
    }
  }

  static Future<Session?> _readSessionFromLocalStorage(
    SharedPreferences? prefs,
  ) async {
    String? json;
    if (prefs != null) {
      json = prefs.getString(_sessionKey);
    } else {
      json = await _secureStorage.read(key: _sessionKey);
    }
    return json == null ? null : Session.fromJson(jsonDecode(json));
  }

  static Future<void> _deleteSessionFromLocalStorage(
    SharedPreferences? prefs,
  ) async {
    if (prefs != null) {
      await prefs.remove(_sessionKey);
    } else {
      await _secureStorage.delete(key: _sessionKey);
    }
  }
}
