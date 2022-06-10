import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/core/usecases/usecase.dart';

import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/repositories/redeeming_repository_impl.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/repositories/redeeming_repository.dart';

final redeemUseCaseProvider = Provider<RedeemUseCase>(
    (ref) => RedeemUseCase(ref.watch(redeemingPartnersRepositoryImplProvider)));

class RedeemUseCase implements UseCase<bool, RedeemingItemsModel> {
  final IRedeemingRepository _iRedeemingRepository;

  RedeemUseCase(this._iRedeemingRepository);

  @override
  Future<Either<Failure, bool>> call(RedeemingItemsModel params) async {
    return await _iRedeemingRepository.redeem(params);
  }
}
