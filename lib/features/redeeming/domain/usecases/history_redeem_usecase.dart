import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/core/usecases/usecase.dart';

import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/repositories/redeeming_repository_impl.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/repositories/redeeming_repository.dart';

final historyRedeemUseCaseProvider = Provider<HistoryRedeemUseCase>((ref) =>
    HistoryRedeemUseCase(ref.watch(redeemingPartnersRepositoryImplProvider)));

class HistoryRedeemUseCase
    implements UseCase<List<RedeemingItemsModel>?, String> {
  final IRedeemingRepository _iRedeemingRepository;

  HistoryRedeemUseCase(this._iRedeemingRepository);

  @override
  Future<Either<Failure, List<RedeemingItemsModel>?>> call(
      String userId) async {
    return await _iRedeemingRepository.getHistoryRedeem(userId);
  }
}
