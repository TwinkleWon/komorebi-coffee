/// Every failure that crosses the data layer boundary is converted into one of
/// these types, so the UI can render a precise message with an exhaustive
/// `switch` instead of inspecting raw exceptions.
sealed class AppException implements Exception {
  const AppException();

  /// `true` when the same request may succeed if simply retried
  /// (transport-level failures). Business errors are never transient.
  bool get isTransient => false;
}

/// The device has no connectivity.
final class NetworkException extends AppException {
  const NetworkException();

  @override
  bool get isTransient => true;

  @override
  String toString() => 'NetworkException()';
}

/// The request was sent but no response arrived in time.
final class RequestTimeoutException extends AppException {
  const RequestTimeoutException();

  @override
  bool get isTransient => true;

  @override
  String toString() => 'RequestTimeoutException()';
}

/// The server responded with a non-success status code.
final class ServerException extends AppException {
  const ServerException(this.statusCode);

  final int statusCode;

  @override
  bool get isTransient => statusCode >= 500;

  @override
  String toString() => 'ServerException($statusCode)';
}

final class CouponAlreadyUsedException extends AppException {
  const CouponAlreadyUsedException();
}

final class CouponExpiredException extends AppException {
  const CouponExpiredException();
}

final class StoreClosedException extends AppException {
  const StoreClosedException();
}

final class InsufficientPointsException extends AppException {
  const InsufficientPointsException();
}

final class NotFoundException extends AppException {
  const NotFoundException();
}

/// Fallback for anything we did not anticipate. Keeps the original error for
/// logging / crash reporting.
final class UnknownException extends AppException {
  const UnknownException(this.cause);

  final Object? cause;

  @override
  String toString() => 'UnknownException($cause)';
}

extension AppExceptionX on Object {
  AppException toAppException() =>
      this is AppException ? this as AppException : UnknownException(this);
}
