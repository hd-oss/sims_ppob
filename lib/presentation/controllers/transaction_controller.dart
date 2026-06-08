import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/async_value_x.dart';
import '../../data/models/history_model.dart';
import '../../di/usecase_providers.dart';

part 'transaction_controller.g.dart';

// ===== New codegen-based implementation =====

/// State imutabel untuk pagination
class PaginationState {
  final int offset;
  final int limit;
  final bool isShowMore;

  const PaginationState({
    this.offset = 0,
    this.limit = 5,
    this.isShowMore = false,
  });

  PaginationState copyWith({
    int? offset,
    int? limit,
    bool? isShowMore,
  }) {
    return PaginationState(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      isShowMore: isShowMore ?? this.isShowMore,
    );
  }
}

/// Notifier untuk mengelola state pagination lokal
@riverpod
class TransactionPagination extends _$TransactionPagination {
  @override
  PaginationState build() => const PaginationState();

  /// Menambah offset & limit untuk "tampilkan lebih banyak"
  void nextPage() {
    state = state.copyWith(
      offset: state.offset + 5,
      limit: state.limit + 5,
      isShowMore: true,
    );
  }

  /// Menandai loading lebih banyak selesai
  void doneLoadingMore() {
    state = state.copyWith(isShowMore: false);
  }
}

/// AsyncNotifier untuk mengelola data riwayat transaksi
@riverpod
class HistoryController extends _$HistoryController {
  @override
  FutureOr<List<HistoryModel>> build() async {
    // Watch pagination state untuk otomatis rebuild saat berubah
    final page = ref.watch(transactionPaginationProvider);

    // Ambil data sebelumnya jika isShowMore untuk akumulasi
    final previous = page.isShowMore
        ? (state.hasValue ? state.value : const <HistoryModel>[])
        : const <HistoryModel>[];

    // Fetch data dari usecase
    final result = await ref
        .watch(historyUseCaseProvider)
        .getHistory(page.offset, page.limit, previous, page.isShowMore);

    // Konversi Either ke nilai/exception untuk AsyncValue
    return unwrapEither(result);
  }
}

/// AsyncNotifier untuk mengelola saldo transaksi
@riverpod
class TransactionBalance extends _$TransactionBalance {
  @override
  FutureOr<String> build() async {
    final result = await ref.watch(historyUseCaseProvider).getBalance();
    return unwrapEither(result);
  }
}
