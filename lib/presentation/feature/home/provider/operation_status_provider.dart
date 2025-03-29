import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'operation_status_provider.g.dart';

enum OperationType {
  none,
  adding,
  deleting,
}

class OperationStatus {
  OperationStatus({
    this.isLoading = false,
    this.message,
    this.isSuccess = false,
    this.operationType = OperationType.none,
  });

  final bool isLoading;
  final String? message;
  final bool isSuccess;
  final OperationType operationType;

  OperationStatus copyWith({
    bool? isLoading,
    String? message,
    bool? isSuccess,
    OperationType? operationType,
  }) {
    return OperationStatus(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
      operationType: operationType ?? this.operationType,
    );
  }

  static OperationStatus initial() {
    return OperationStatus();
  }
}

@Riverpod(keepAlive: true)
class OperationStatusNotifier extends _$OperationStatusNotifier {
  @override
  OperationStatus build() {
    return OperationStatus.initial();
  }

  void startOperation(OperationType type, {String? message}) {
    state = OperationStatus(
      isLoading: true,
      message: message ?? 'Operation in progress...',
      operationType: type,
    );
  }

  void operationSuccess(String message) {
    state = state.copyWith(
      isLoading: false,
      message: message,
      isSuccess: true,
    );
  }

  void operationFailed(String errorMessage) {
    state = state.copyWith(
      isLoading: false,
      message: errorMessage,
      isSuccess: false,
    );
  }

  void reset() {
    state = OperationStatus.initial();
  }
}
