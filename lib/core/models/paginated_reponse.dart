class PaginatedResponse<T> {
  final List<T> data;
  final int total;
  final int totalQuery;
  final int status;
  final bool error;
  final bool success;

  PaginatedResponse({
    required this.data,
    required this.total,
    required this.totalQuery,
    required this.status,
    required this.error,
    required this.success,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return PaginatedResponse(
      data: (json['data'] as List)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] ?? 0,
      totalQuery: json['totalQuery'] ?? 0,
      status: json['status'] ?? 200,
      error: json['error'] ?? false,
      success: json['success'] ?? true,
    );
  }

  // Helper method to check if the response is successful
  bool isSuccessful() => success && !error && status == 200;

  // Helper method to get total pages based on a page size
  int getTotalPages(int pageSize) {
    return (total / pageSize).ceil();
  }

  // Helper method to check if there's more data
  bool hasMore(int currentPage, int pageSize) {
    return currentPage * pageSize < total;
  }
}
