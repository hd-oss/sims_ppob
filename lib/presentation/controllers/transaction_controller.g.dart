// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier untuk mengelola state pagination lokal

@ProviderFor(TransactionPagination)
final transactionPaginationProvider = TransactionPaginationProvider._();

/// Notifier untuk mengelola state pagination lokal
final class TransactionPaginationProvider
    extends $NotifierProvider<TransactionPagination, PaginationState> {
  /// Notifier untuk mengelola state pagination lokal
  TransactionPaginationProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'transactionPaginationProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$transactionPaginationHash();

  @$internal
  @override
  TransactionPagination create() => TransactionPagination();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaginationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaginationState>(value),
    );
  }
}

String _$transactionPaginationHash() =>
    r'0e73a3eb506edaedbfa2827505610dff52e2ae61';

/// Notifier untuk mengelola state pagination lokal

abstract class _$TransactionPagination extends $Notifier<PaginationState> {
  PaginationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PaginationState, PaginationState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PaginationState, PaginationState>,
        PaginationState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// AsyncNotifier untuk mengelola data riwayat transaksi

@ProviderFor(HistoryController)
final historyControllerProvider = HistoryControllerProvider._();

/// AsyncNotifier untuk mengelola data riwayat transaksi
final class HistoryControllerProvider
    extends $AsyncNotifierProvider<HistoryController, List<HistoryModel>> {
  /// AsyncNotifier untuk mengelola data riwayat transaksi
  HistoryControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'historyControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$historyControllerHash();

  @$internal
  @override
  HistoryController create() => HistoryController();
}

String _$historyControllerHash() => r'32a7ff9b526afb852e666a581dc1127b7a5e4920';

/// AsyncNotifier untuk mengelola data riwayat transaksi

abstract class _$HistoryController extends $AsyncNotifier<List<HistoryModel>> {
  FutureOr<List<HistoryModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<HistoryModel>>, List<HistoryModel>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<HistoryModel>>, List<HistoryModel>>,
        AsyncValue<List<HistoryModel>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// AsyncNotifier untuk mengelola saldo transaksi

@ProviderFor(TransactionBalance)
final transactionBalanceProvider = TransactionBalanceProvider._();

/// AsyncNotifier untuk mengelola saldo transaksi
final class TransactionBalanceProvider
    extends $AsyncNotifierProvider<TransactionBalance, String> {
  /// AsyncNotifier untuk mengelola saldo transaksi
  TransactionBalanceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'transactionBalanceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$transactionBalanceHash();

  @$internal
  @override
  TransactionBalance create() => TransactionBalance();
}

String _$transactionBalanceHash() =>
    r'c06002afe1fdda1919d1b97a4cec65e6cac48928';

/// AsyncNotifier untuk mengelola saldo transaksi

abstract class _$TransactionBalance extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<String>, String>,
        AsyncValue<String>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
