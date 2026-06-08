import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sims_ppob/presentation/controllers/transaction_controller.dart';

void main() {
  group('PaginationState', () {
    test('should have default values', () {
      const state = PaginationState();
      
      expect(state.offset, 0);
      expect(state.limit, 5);
      expect(state.isShowMore, false);
    });

    test('copyWith should update specified fields', () {
      const state = PaginationState();
      
      final newState = state.copyWith(offset: 5, limit: 10, isShowMore: true);
      
      expect(newState.offset, 5);
      expect(newState.limit, 10);
      expect(newState.isShowMore, true);
    });

    test('copyWith should retain unspecified fields', () {
      const state = PaginationState(offset: 10, limit: 15, isShowMore: true);
      
      final newState = state.copyWith(offset: 20);
      
      expect(newState.offset, 20);
      expect(newState.limit, 15); // tidak berubah
      expect(newState.isShowMore, true); // tidak berubah
    });
  });

  group('TransactionPagination', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should have initial state with default values', () {
      final state = container.read(transactionPaginationProvider);
      
      expect(state.offset, 0);
      expect(state.limit, 5);
      expect(state.isShowMore, false);
    });

    test('nextPage should increase offset and limit by 5 and set isShowMore to true', () {
      final notifier = container.read(transactionPaginationProvider.notifier);
      
      notifier.nextPage();
      
      final state = container.read(transactionPaginationProvider);
      expect(state.offset, 5);
      expect(state.limit, 10);
      expect(state.isShowMore, true);
    });

    test('nextPage called multiple times should continue increasing', () {
      final notifier = container.read(transactionPaginationProvider.notifier);
      
      notifier.nextPage();
      notifier.nextPage();
      
      final state = container.read(transactionPaginationProvider);
      expect(state.offset, 10);
      expect(state.limit, 15);
      expect(state.isShowMore, true);
    });

    test('doneLoadingMore should set isShowMore to false', () {
      final notifier = container.read(transactionPaginationProvider.notifier);
      
      notifier.nextPage(); // isShowMore = true
      notifier.doneLoadingMore();
      
      final state = container.read(transactionPaginationProvider);
      expect(state.isShowMore, false);
      expect(state.offset, 5); // offset tetap
      expect(state.limit, 10); // limit tetap
    });
  });
}
