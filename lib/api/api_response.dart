/// A generic class representing an API response.
class ApiResponse<T> {
  final T? data;
  final int? status;
  final String? error;

  bool get isSuccess => error == null;

  ApiResponse.success(this.data, {this.status}) : error = null;

  ApiResponse.error(this.error)
      : data = null,
        status = null;
}
