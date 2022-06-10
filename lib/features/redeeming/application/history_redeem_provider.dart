import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/provider/base_provider.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/usecases/history_redeem_usecase.dart';
import 'package:flutter_steps_tracker/services/firebase/firebase_client.dart';

final historyRedeemProvider =
    StateNotifierProvider<HistoryRedeemProvider, ViewState>(
        (ref) => HistoryRedeemProvider(
              ref.watch(historyRedeemUseCaseProvider),
              ref.watch(firebaseClientProvider).auth.currentUser?.uid ?? '',
            ));

class HistoryRedeemProvider extends BaseProvider<List<RedeemingItemsModel>> {
  final HistoryRedeemUseCase _historyRedeemProvider;
  final String userId;

  HistoryRedeemProvider(this._historyRedeemProvider, this.userId);
  Future<void> getHistoryRedeem() async {
    setLoadingState();
    final response = await _historyRedeemProvider.call(userId);
    response.fold((failure) {
      setErrorState(failure.message);
    }, (item) {
      if (item != null) {
        setLoadedState(item);
      }
    });
  }

  int totalRedeemedPoint() {
    try {
      return (state as LoadedViewState<List<RedeemingItemsModel>>)
          .data
          .map((e) => e.points)
          .reduce((prev, next) => prev + next);
    } catch (e) {
      return 0;
    }
  }
}
