import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/widgets/loader_widget.dart';
import 'package:flutter_steps_tracker/features/redeeming/application/redeeming_provider.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/entities/redeeming_entity.dart';
import 'package:flutter_steps_tracker/features/redeeming/presentation/widgets/partners_widget.dart';
import 'package:flutter_steps_tracker/routes/app_router.gr.dart';
import 'package:flutter_steps_tracker/theme/dimensions.dart';
import 'package:flutter_steps_tracker/utils/ui_helper.dart';

class RedeemingScreen extends ConsumerStatefulWidget {
  const RedeemingScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RedeemingScreenState();
}

class _RedeemingScreenState extends ConsumerState<RedeemingScreen> {
  @override
  initState() {
    super.initState();
    UiHelper.postBuildCallback((p0) {
      ref.read(redeemingProvider.notifier).gatAllRedeemingPartners();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(redeemingProvider);
    print(state);
    // CollectionReference partners =
    //     FirebaseFirestore.instance.collection('partners');
    // return FutureBuilder<DocumentSnapshot>(
    //   future: partners.doc('8EXznomYnGRXdAGdoPsi').get(),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text("Something went wrong");
    //     }
    //
    //     if (snapshot.hasData && !snapshot.data!.exists) {
    //       return Text("Document does not exist");
    //     }
    //
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data =
    //           snapshot.data!.data() as Map<String, dynamic>;
    //       print(snapshot.data?.data());
    //       return Text("Full Name: ${data['name']} ${data['image']}");
    //     }
    //
    //     return Text("loading");
    //   },
    // );
    if (state is LoadingViewState) {
      return const LoaderWidget();
    }
    if (state is LoadedViewState<List<RedeemingEntity>>) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.kSizeLarge,
          vertical: AppDimensions.kSizeMedium,
        ),
        itemCount: state.data.length,
        itemBuilder: (context, index) => PartnersWidget(
          imageUrl: state.data[index].image,
          partnerName: state.data[index].name,
          heroTag: state.data[index].name,
          onTap: () =>
              context.pushRoute(RedeemingDetailsRoute(item: state.data[index])),
        ),
      );
    }
    return const SizedBox();
  }
}
