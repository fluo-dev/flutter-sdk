class ApiError {
  const ApiError({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'],
    );
  }

  final int code;
  final String message;
  final dynamic data;

  ApiError copyWith({
    int? code,
    String? message,
    dynamic data,
  }) {
    return ApiError(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
