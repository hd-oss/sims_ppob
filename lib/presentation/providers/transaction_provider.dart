import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/transaction_controller.dart';

final transactionProvider =
    StateNotifierProvider<TransactionController, TransactionState>(
        (ref) => TransactionController());
