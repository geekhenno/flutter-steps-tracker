import 'package:dartz/dartz.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/usecases/update_steps_points_usecase.dart';

abstract class IDashboardRepository {
  Future<Either<Failure, List<DashboardEntity>?>> getUserDashboard();
  Future<Either<Failure, bool>> updateUserStepsAndPoints(
      UpdateStepsPointsParams params);
}
