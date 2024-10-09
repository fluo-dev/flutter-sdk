import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/api_error.dart';
import 'models/app_config.dart';
import 'models/partial_session.dart';
import 'models/session.dart';

final class Error {
  static int unauthorized = 401;
  static int conflict = 409;
}

class ApiClient {
  ApiClient(this.apiKey);

  static const String baseUrl = 'https://fluo-pocketbase.fly.dev/api/v1';

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

  Future<PartialSession> createSession({
    String? email,
  }) async {
    final body = <String, dynamic>{
      'email': email,
    };

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

  Future<Session> verifySession({
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

  Future<Session> refreshToken({
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

    return;
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
