import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_view.dart';
import 'skeleton.dart';

/// Renders the three states of an [AsyncValue] consistently across the app.
///
/// - First load and retry-after-error show [loading].
/// - Pull-to-refresh keeps showing the current data.
/// - A failed refresh keeps the previous data instead of a full-screen error.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    required this.onRetry,
    this.loading,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback onRetry;
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnRefresh: !value.hasError,
      skipError: value.hasValue,
      data: data,
      loading: () => loading ?? const SkeletonList(),
      error: (error, _) => ErrorView(error: error, onRetry: onRetry),
    );
  }
}
