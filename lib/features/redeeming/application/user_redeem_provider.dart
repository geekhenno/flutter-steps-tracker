import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/provider/base_provider.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/usecases/redeem_usecase.dart';

final userRedeemProvider = StateNotifierProvider<UserRedeemProvider, ViewState>(
    (ref) => UserRedeemProvider(
          ref.watch(redeemUseCaseProvider),
        ));

class UserRedeemProvider extends BaseProvider<bool> {
  final RedeemUseCase _redeemUseCase;

  UserRedeemProvider(
    this._redeemUseCase,
  );

  void redeem(RedeemingItemsModel item) async {
    setLoadingState();
    final response = await _redeemUseCase.call(item);
    response.fold((failure) {
      setErrorState(failure.message);
    }, (item) {
      setLoadedState(item);
    });
  }
}
