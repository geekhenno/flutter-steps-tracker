import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/widgets/image_network_widget.dart';
import 'package:flutter_steps_tracker/core/widgets/loader_widget.dart';
import 'package:flutter_steps_tracker/features/dashboard/application/dashboard_provider.dart';
import 'package:flutter_steps_tracker/features/redeeming/application/history_redeem_provider.dart';
import 'package:flutter_steps_tracker/features/redeeming/application/user_redeem_provider.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/entities/redeeming_entity.dart';
import 'package:flutter_steps_tracker/features/redeeming/presentation/widgets/partners_widget.dart';
import 'package:flutter_steps_tracker/services/firebase/firebase_client.dart';
import 'package:flutter_steps_tracker/theme/colors.dart';
import 'package:flutter_steps_tracker/theme/dimensions.dart';
import 'package:flutter_steps_tracker/utils/constants/enums.dart';
import 'package:flutter_steps_tracker/utils/ui_helper.dart';

class RedeemingDetailsScreen extends ConsumerStatefulWidget {
  final RedeemingEntity item;
  const RedeemingDetailsScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RedeemingDetailsState();
}

class _RedeemingDetailsState extends ConsumerState<RedeemingDetailsScreen> {
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
    ref.listen(userRedeemProvider, (previous, state) {
      if (state is LoadingViewState) {
        UiHelper.showLoadingDialog(context);
      } else if (state is ErrorViewState) {
        Navigator.pop(context);
        UiHelper.showNotification('تعذر الاسترداد ');
      } else if (state is LoadedViewState<bool>) {
        Navigator.pop(context);
        if (state.data) {
          UiHelper.showNotification('تم الاسترداد بنجاح',
              notificationType: NotificationType.success);
        } else {
          UiHelper.showNotification('تعذر الاسترداد ');
        }
      }
    });
    return Scaffold(body: () {
      if (state is LoadingViewState) {
        return const LoaderWidget();
      }
      if (state is LoadedViewState<List<RedeemingItemsModel>>) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              stretch: true,
              pinned: true,
              backgroundColor: AppColors.primary,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.item.name),
                background: Hero(
                  tag: widget.item.name,
                  child: ImageNetworkWidget(
                    imageUrl: widget.item.image,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.kSizeMedium,
                vertical: AppDimensions.kSizeLarge,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final item = widget.item.items[index];
                    return PartnersWidget(
                      imageUrl: item.itemImage,
                      partnerName: item.name,
                      onTap: () async {
                        final points =
                            ref.read(dashboardProvider.notifier).totalPoints();
                        final redeemedPoint = ref
                            .read(historyRedeemProvider.notifier)
                            .totalRedeemedPoint();

                        if (points - redeemedPoint > item.points) {
                          ref
                              .read(userRedeemProvider.notifier)
                              .redeem(item.copyWith(
                                createdOn: Timestamp.now(),
                                userId: ref
                                    .read(firebaseClientProvider)
                                    .auth
                                    .currentUser
                                    ?.uid,
                              ));
                        } else {
                          UiHelper.showNotification('نقاطك لا تكفي للاسترداد');
                        }
                      },
                    );
                  },
                  childCount: widget.item.items.length,
                ),
              ),
            )
          ],
        );
      }
    }());
  }
}
