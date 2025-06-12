import 'dart:convert';

import 'package:fluo/api/models/api_error.dart';
import 'package:fluo/api/models/app_config.dart';
import 'package:fluo/api/models/partial_session.dart';
import 'package:fluo/api/models/session.dart';
import 'package:http/http.dart' as http;

final class Error {
  static int unauthorized = 401;
  static int conflict = 409;
}

class ApiClient {
  ApiClient(this.apiKey);

  //static const String baseUrl = 'https://fluo-pocketbase.fly.dev/api/v1';
  static const String baseUrl = 'http://127.0.0.1:8090/api/v1';

  final String apiKey;

  String language = 'en_US';

  // API requests

  Future<AppConfig> getAppConfig() async {
    final response = await _get(
      path: '/config',
    );

    final json = jsonDecode(response.body);

    if (response.statusCode >= 400) {
      return Future.error(ApiError.fromJson(json));
    }

    return AppConfig.fromJson(json);
  }

  Future<PartialSession> createPartialSession({
    String? email,
    String? mobileE164,
    String? mobileIso2,
    String? mobileLocal,
  }) async {
    final body = <String, dynamic>{};

    if (email != null) {
      body['email'] = email;
    }

    if (mobileE164 != null) {
      body['mobileE164'] = mobileE164;
    }

    if (mobileIso2 != null) {
      body['mobileIso2'] = mobileIso2;
    }

    if (mobileLocal != null) {
      body['mobileLocal'] = mobileLocal;
    }

    final response = await _post(
      path: '/sessions',
      body: body,
    );

    final json = jsonDecode(response.body);

    if (response.statusCode >= 400) {
      return Future.error(ApiError.fromJson(json));
    }

    return PartialSession.fromJson(json);
  }

  Future<Session> verifyPartialSession({
    required String partialSessionId,
    required String code,
  }) async {
    final body = <String, dynamic>{
      'code': code,
    };

    final response = await _post(
      path: '/sessions/$partialSessionId/verify',
      body: body,
    );

    final json = jsonDecode(response.body);

    if (response.statusCode >= 400) {
      return Future.error(ApiError.fromJson(json));
    }

    return Session.fromJson(json);
  }

  Future<Session> createSession({
    String? googleIdToken,
    String? appleIdToken,
    String? firstName,
    String? lastName,
  }) async {
    final body = <String, dynamic>{};

    if (googleIdToken != null) {
      body['googleIdToken'] = googleIdToken;
    }

    if (appleIdToken != null) {
      body['appleIdToken'] = appleIdToken;
    }

    if (firstName != null) {
      body['firstName'] = firstName;
    }

    if (lastName != null) {
      body['lastName'] = lastName;
    }

    final response = await _post(
      path: '/sessions',
      body: body,
    );

    final json = jsonDecode(response.body);

    if (response.statusCode >= 400) {
      return Future.error(ApiError.fromJson(json));
    }

    return Session.fromJson(json);
  }

  Future<Session> refreshSession({
    required String sessionId,
    required String refreshToken,
  }) async {
    final body = <String, dynamic>{
      'refreshToken': refreshToken,
    };

    final response = await _post(
      path: '/sessions/$sessionId/refresh',
      body: body,
    );

    final json = jsonDecode(response.body);

    if (response.statusCode >= 400) {
      return Future.error(ApiError.fromJson(json));
    }

    return Session.fromJson(json);
  }

  Future<void> updateUser({
    required String accessToken,
    String? firstName,
    String? lastName,
  }) async {
    final body = <String, dynamic>{};

    if (firstName != null) {
      body['firstName'] = firstName;
    }

    if (lastName != null) {
      body['lastName'] = lastName;
    }

    final response = await _patch(
      path: '/users/me',
      body: body,
      accessToken: accessToken,
    );

    if (response.statusCode >= 400) {
      final json = jsonDecode(response.body);
      return Future.error(ApiError.fromJson(json));
    }
  }

  // Request helpers

  Future<http.Response> _get({
    required String path,
    String? accessToken,
  }) {
    return http.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers(accessToken),
    );
  }

  Future<http.Response> _post({
    required String path,
    required Map<String, dynamic> body,
    String? accessToken,
  }) {
    return http.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers(accessToken),
      body: jsonEncode(body),
    );
  }

  Future<http.Response> _patch({
    required String path,
    required Map<String, dynamic> body,
    String? accessToken,
  }) {
    return http.patch(
      Uri.parse('$baseUrl$path'),
      headers: _headers(accessToken),
      body: jsonEncode(body),
    );
  }

  Map<String, String> _headers(String? accessToken) {
    final headers = {
      'accept-language': language,
      'content-type': 'application/json; charset=UTF-8',
      'x-api-key': apiKey,
    };

    if (accessToken != null) {
      headers['authorization'] = 'Bearer $accessToken';
    }

    return headers;
  }
}
