import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import 'app_exception.dart';

class ErrorDescription {
  const ErrorDescription({
    required this.title,
    required this.message,
    required this.icon,
  });

  final String title;
  final String message;
  final IconData icon;
}

/// Maps any error to user-facing copy. The sealed [AppException] hierarchy
/// makes this switch exhaustive, so adding a new error type is a compile
/// error until it gets a message.
ErrorDescription describeError(AppLocalizations l10n, Object error) {
  return switch (error.toAppException()) {
    NetworkException() => ErrorDescription(
        title: l10n.errorNetworkTitle,
        message: l10n.errorNetworkMessage,
        icon: Icons.wifi_off_rounded,
      ),
    RequestTimeoutException() => ErrorDescription(
        title: l10n.errorTimeoutTitle,
        message: l10n.errorTimeoutMessage,
        icon: Icons.hourglass_empty_rounded,
      ),
    ServerException(:final statusCode) => ErrorDescription(
        title: l10n.errorServerTitle,
        message: l10n.errorServerMessage(statusCode),
        icon: Icons.cloud_off_rounded,
      ),
    CouponAlreadyUsedException() => ErrorDescription(
        title: l10n.errorGenericTitle,
        message: l10n.errorCouponAlreadyUsed,
        icon: Icons.confirmation_number_outlined,
      ),
    CouponExpiredException() => ErrorDescription(
        title: l10n.errorGenericTitle,
        message: l10n.errorCouponExpired,
        icon: Icons.event_busy_outlined,
      ),
    StoreClosedException() => ErrorDescription(
        title: l10n.errorGenericTitle,
        message: l10n.errorStoreClosed,
        icon: Icons.storefront_outlined,
      ),
    InsufficientPointsException() => ErrorDescription(
        title: l10n.errorGenericTitle,
        message: l10n.errorInsufficientPoints,
        icon: Icons.toll_outlined,
      ),
    NotFoundException() => ErrorDescription(
        title: l10n.errorGenericTitle,
        message: l10n.errorNotFound,
        icon: Icons.search_off_rounded,
      ),
    UnknownException() => ErrorDescription(
        title: l10n.errorGenericTitle,
        message: l10n.errorUnknownMessage,
        icon: Icons.error_outline_rounded,
      ),
  };
}

/// Shows a snackbar for a failed user action, with a retry button when the
/// failure is transient.
void showErrorSnackBar(
  BuildContext context,
  Object error, {
  VoidCallback? onRetry,
}) {
  final l10n = context.l10n;
  final description = describeError(l10n, error);
  final canRetry = onRetry != null && error.toAppException().isTransient;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(description.message),
        action: canRetry
            ? SnackBarAction(label: l10n.retry, onPressed: onRetry)
            : null,
      ),
    );
}
