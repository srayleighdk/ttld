class ApiResponseList<T> {
  final List<T>? data;
  final int? total;
  final String? message;
  final bool success;

  ApiResponseList({
    this.data,
    this.total,
    this.message,
    this.success = false,
  });

  factory ApiResponseList.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ApiResponseList(
      data: json['data'] != null ? List<T>.from(json['data'].map((x) => fromJson(x))) : null,
      total: json['total'],
      message: json['message'],
      success: json['success'] ?? false,
    );
  }
} 