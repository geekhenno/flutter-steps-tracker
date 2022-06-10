import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/provider/base_provider.dart';
import 'package:flutter_steps_tracker/core/usecases/usecase.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/entities/redeeming_entity.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/usecases/redeeming_partners_usecase.dart';

final redeemingProvider = StateNotifierProvider<RedeemingProvider, ViewState>(
    (ref) => RedeemingProvider(
          ref.watch(redeemingPartnersUseCaseProvider),
        ));

class RedeemingProvider extends BaseProvider<List<RedeemingEntity>> {
  final RedeemingPartnersUseCase _redeemingPartnersUseCase;

  RedeemingProvider(
    this._redeemingPartnersUseCase,
  );
  Future<void> gatAllRedeemingPartners() async {
    setLoadingState();
    final response = await _redeemingPartnersUseCase.call(NoParams());
    response.fold((failure) {
      setErrorState(failure.message);
    }, (user) {
      if (user != null) {
        setLoadedState(user);
      }
    });
  }
}
