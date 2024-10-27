import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/result_state.dart';

class TransactionState {
  final ResultState? userData;
  final ResultState? bannerData;
  final ResultState? balanceData;
  final ResultState? serviceData;

  TransactionState(
      {this.userData, this.bannerData, this.balanceData, this.serviceData});
}

class TransactionController extends StateNotifier<TransactionState> {
  TransactionController() : super(TransactionState());

  Future<void> initState() async {}
}
