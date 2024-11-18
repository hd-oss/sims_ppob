import '../../common/result_state.dart';
import '../repositories/purches_repository.dart';

class PurchesUseCase {
  final PurchesRepository purchesRepository;

  PurchesUseCase(this.purchesRepository);

  Future<ResultState<String>> getBalance() async {
    final result = await purchesRepository.getBalance();
    return result.fold(
      (message) => ResultState.error(message),
      (data) => ResultState.success(data),
    );
  }

  Future<ResultState<String>> purchesEvent(String serviceCode) async {
    final result = await purchesRepository.purchesEvent(serviceCode);
    return result.fold(
      (message) => ResultState.error(message, serviceCode),
      (data) => ResultState.success(serviceCode),
    );
  }
}
