import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/provider/base_provider.dart';
import 'package:flutter_steps_tracker/features/bottom_navigation/application/steps_provider.dart';

import 'package:flutter_steps_tracker/features/dashboard/domain/usecases/update_steps_points_usecase.dart';
import 'package:flutter_steps_tracker/services/firebase/firebase_client.dart';

final updateStepsPointsProvider =
    StateNotifierProvider<UpdateStepsPointsProvider, ViewState>(
        (ref) => UpdateStepsPointsProvider(
              ref.watch(updateStepsPointsUseCaseProvider),
              UpdateStepsPointsParams(
                  points: ref.watch(pointsProvider),
                  steps: ref.watch(stepsProvider)?.steps ?? 0,
                  userId:
                      ref.watch(firebaseClientProvider).auth.currentUser?.uid ??
                          ''),
            ));

class UpdateStepsPointsProvider extends BaseProvider<bool> {
  final UpdateStepsPointsUseCase _updateStepsPointsUseCase;
  final UpdateStepsPointsParams _updateStepsPointsParams;

  UpdateStepsPointsProvider(
    this._updateStepsPointsUseCase,
    this._updateStepsPointsParams,
  );
  Future<void> updateStepsPoints() async {
    final response =
        await _updateStepsPointsUseCase.call(_updateStepsPointsParams);
    response.fold((failure) {}, (data) {});
  }
}
