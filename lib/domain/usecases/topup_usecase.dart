import '../../common/result_state.dart';
import '../repositories/topup_repository.dart';

class TopupUseCase {
  final TopupRepository topupRepository;

  TopupUseCase(this.topupRepository);

  Future<ResultState<String>> getBalance() async {
    final result = await topupRepository.getBalance();
    return result.fold(
      (message) => ResultState.error(message),
      (data) => ResultState.success(data),
    );
  }

  Future<ResultState<String>> topupEvent(String amount) async {
    final result = await topupRepository.topupEvent(amount);
    return result.fold(
      (message) => ResultState.error(message, amount),
      (data) => ResultState.success(amount),
    );
  }
}
