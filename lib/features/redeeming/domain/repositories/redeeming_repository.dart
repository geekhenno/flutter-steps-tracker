import 'package:dartz/dartz.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/entities/redeeming_entity.dart';

abstract class IRedeemingRepository {
  Future<Either<Failure, List<RedeemingEntity>?>> getAllRedeemingPartners();
  Future<Either<Failure, List<RedeemingItemsModel>?>> getHistoryRedeem(
      String userId);
  Future<Either<Failure, bool>> redeem(RedeemingItemsModel item);
}
