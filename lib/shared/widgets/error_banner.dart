import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';

class ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorBanner({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.cloud_off_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Colors.white.withValues(alpha: 0.25)),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 15,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, color: AppTheme.primary),
                label: const Text(
                  'Reintentar',
                  style: TextStyle(color: AppTheme.primary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Colors.white.withValues(alpha: 0.2)),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 15,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add_rounded, color: AppTheme.primary),
                label: Text(
                  actionLabel!,
                  style: const TextStyle(color: AppTheme.primary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppTheme.primary),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final String? loadingMessage;
  final String? errorMessage;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loadingMessage,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => LoadingWidget(message: loadingMessage),
      error: (e, _) => ErrorBanner(
        message: errorMessage ?? 'Error al cargar los datos',
      ),
    );
  }
}
