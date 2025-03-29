import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/presentation/feature/home/provider/operation_status_provider.dart';

class OperationLoader extends ConsumerWidget {
  const OperationLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final operationStatus = ref.watch(operationStatusNotifierProvider);

    if (!operationStatus.isLoading) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            operationStatus.message ?? 'Loading...',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

extension OperationStatusSnackbarX on BuildContext {
  void showOperationResult(OperationStatus status) {
    if (!status.isLoading && status.message != null) {
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(status.message!),
          backgroundColor: status.isSuccess ? Colors.green : Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
