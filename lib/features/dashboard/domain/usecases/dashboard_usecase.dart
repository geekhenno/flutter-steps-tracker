import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/core/usecases/usecase.dart';
import 'package:flutter_steps_tracker/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/repositories/dashboard_repository.dart';

final dashboardUseCaseProvider = Provider<DashboardUseCase>(
    (ref) => DashboardUseCase(ref.watch(dashboardRepositoryImplProvider)));

class DashboardUseCase implements UseCase<List<DashboardEntity>?, NoParams> {
  final IDashboardRepository _dashboardRepository;

  DashboardUseCase(this._dashboardRepository);

  @override
  Future<Either<Failure, List<DashboardEntity>?>> call(NoParams params) async {
    return await _dashboardRepository.getUserDashboard();
  }
}
