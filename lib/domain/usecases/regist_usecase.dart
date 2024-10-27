import '../../common/result_state.dart';
import '../../data/models/regist_model.dart';
import '../repositories/regist_repository.dart';



class RegistUseCase {
  final RegistRepository repository;

  RegistUseCase(this.repository);

  Future<ResultState<String>> regist(RegistModel? params) async {
    if (params == null) {
      return ResultState.error('Lengkapi data');
    }
    if (params.password != params.confirmPassword) {
      return ResultState.error('Password tidak sama');
    }

    final result = await repository.regist(params.toJson());
    return result.fold(
      (message) => ResultState.error(message),
      (data) => ResultState.success(data),
    );
  }
}
