class ApiResponseObject<T> {
  final T? data;
  final String? message;
  final bool success;

  ApiResponseObject({
    this.data,
    this.message,
    this.success = false,
  });

  factory ApiResponseObject.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ApiResponseObject(
      data: json['data'] != null ? fromJson(json['data']) : null,
      message: json['message'],
      success: json['success'] ?? false,
    );
  }
} 