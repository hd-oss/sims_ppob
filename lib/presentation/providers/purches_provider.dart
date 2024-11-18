import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/purches_usecase.dart';
import '../../injection_container.dart';
import '../controllers/purches_controller.dart';

final purchesProvider =
    StateNotifierProvider<PurchesController, PurchesState>((ref) {
  final provider = PurchesController(sl<PurchesUseCase>());
  return provider;
});
