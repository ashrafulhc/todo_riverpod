import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'operation_status_provider.g.dart';

class OperationStatus {
  OperationStatus({
    this.isLoading = false,
    this.message,
    this.isSuccess = false,
  });

  final bool isLoading;
  final String? message;
  final bool isSuccess;

  OperationStatus copyWith({
    bool? isLoading,
    String? message,
    bool? isSuccess,
  }) {
    return OperationStatus(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

@Riverpod(keepAlive: true)
class OperationStatusNotifier extends _$OperationStatusNotifier {
  @override
  OperationStatus build() {
    return OperationStatus();
  }

  void startOperation({String? message}) {
    state = OperationStatus(
      isLoading: true,
      message: message ?? 'Operation in progress...',
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
    state = OperationStatus();
  }
}
