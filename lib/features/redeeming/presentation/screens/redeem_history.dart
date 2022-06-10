import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/widgets/app_bar_widget.dart';
import 'package:flutter_steps_tracker/core/widgets/loader_widget.dart';
import 'package:flutter_steps_tracker/features/redeeming/application/history_redeem_provider.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';
import 'package:flutter_steps_tracker/features/redeeming/presentation/widgets/partners_widget.dart';
import 'package:flutter_steps_tracker/theme/dimensions.dart';
import 'package:flutter_steps_tracker/utils/ui_helper.dart';

class RedeemHistoryScreen extends ConsumerStatefulWidget {
  const RedeemHistoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RedeemHistoryScreen> createState() =>
      _RedeemHistoryScreenState();
}

class _RedeemHistoryScreenState extends ConsumerState<RedeemHistoryScreen> {
  @override
  initState() {
    super.initState();
    UiHelper.postBuildCallback((p0) {
      ref.read(historyRedeemProvider.notifier).getHistoryRedeem();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historyRedeemProvider);
    print(state);
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'الاسترداد',
      ),
      body: () {
        if (state is LoadingViewState) {
          return const LoaderWidget();
        } else if (state is LoadedViewState<List<RedeemingItemsModel>>) {
          return ListView.builder(
              padding: const EdgeInsets.all(
                AppDimensions.kSizeMedium,
              ),
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final item = state.data[index];

                return PartnersWidget(
                  imageUrl: item.itemImage,
                  partnerName: item.name,
                  points: '${item.points} نقطة',
                  date:
                      '${item.createdOn?.toDate().year}/${item.createdOn?.toDate().month}/${item.createdOn?.toDate().day}',
                  onTap: () {},
                );
              });
        }
      }(),
    );
  }
}
