import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/core/usecases/usecase.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/repositories/redeeming_repository_impl.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/entities/redeeming_entity.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/repositories/redeeming_repository.dart';

final redeemingPartnersUseCaseProvider = Provider<RedeemingPartnersUseCase>(
    (ref) => RedeemingPartnersUseCase(
        ref.watch(redeemingPartnersRepositoryImplProvider)));

class RedeemingPartnersUseCase
    implements UseCase<List<RedeemingEntity>?, NoParams> {
  final IRedeemingRepository _iRedeemingRepository;

  RedeemingPartnersUseCase(this._iRedeemingRepository);

  @override
  Future<Either<Failure, List<RedeemingEntity>?>> call(NoParams params) async {
    return await _iRedeemingRepository.getAllRedeemingPartners();
  }
}
