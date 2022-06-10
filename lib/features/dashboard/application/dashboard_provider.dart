import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/provider/base_provider.dart';
import 'package:flutter_steps_tracker/core/usecases/usecase.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/usecases/dashboard_usecase.dart';

final dashboardProvider = StateNotifierProvider<DashboardProvider, ViewState>(
    (ref) => DashboardProvider(
          ref.watch(dashboardUseCaseProvider),
        ));

class DashboardProvider extends BaseProvider<List<DashboardEntity>> {
  final DashboardUseCase _dashboardUseCase;

  DashboardProvider(
    this._dashboardUseCase,
  );
  Future<void> getUserDashboard() async {
    setLoadingState();
    final response = await _dashboardUseCase.call(NoParams());
    response.fold((failure) {
      setErrorState(failure.message);
    }, (items) {
      if (items != null) {
        setLoadedState(items);
      }
    });
  }

  int totalSteps() {
    try {
      return (state as LoadedViewState<List<DashboardEntity>>)
          .data
          .map((item) => item.totalSteps)
          .reduce((prev, next) => prev + next);
    } catch (e) {
      return 0;
    }
  }

  int totalPoints() {
    try {
      return (state as LoadedViewState<List<DashboardEntity>>)
          .data
          .map((item) => item.totalPoints)
          .reduce((prev, next) => prev + next);
    } catch (e) {
      return 0;
    }
  }
}
