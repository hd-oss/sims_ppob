import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/history_usecase.dart';
import '../../injection_container.dart';

import '../controllers/transaction_controller.dart';

final transactionProvider =
    StateNotifierProvider<TransactionController, TransactionState>(
        (ref) => TransactionController(sl<HistoryUseCase>()));
