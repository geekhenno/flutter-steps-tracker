import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/core/usecases/usecase.dart';
import 'package:flutter_steps_tracker/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/repositories/dashboard_repository.dart';

final updateStepsPointsUseCaseProvider = Provider<UpdateStepsPointsUseCase>(
    (ref) =>
        UpdateStepsPointsUseCase(ref.watch(dashboardRepositoryImplProvider)));

class UpdateStepsPointsUseCase
    implements UseCase<bool, UpdateStepsPointsParams> {
  final IDashboardRepository _dashboardRepository;

  UpdateStepsPointsUseCase(this._dashboardRepository);

  @override
  Future<Either<Failure, bool>> call(UpdateStepsPointsParams params) async {
    return await _dashboardRepository.updateUserStepsAndPoints(params);
  }
}

class UpdateStepsPointsParams {
  final int steps;
  final int points;
  final String userId;

  UpdateStepsPointsParams({
    required this.steps,
    required this.points,
    required this.userId,
  });
}
