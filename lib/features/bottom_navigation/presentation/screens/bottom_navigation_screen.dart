import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/widgets/app_bar_widget.dart';
import 'package:flutter_steps_tracker/features/bottom_navigation/application/steps_provider.dart';
import 'package:flutter_steps_tracker/features/dashboard/application/update_steps_points_provider.dart';
import 'package:flutter_steps_tracker/routes/app_router.gr.dart';
import 'package:flutter_steps_tracker/theme/colors.dart';
import 'package:flutter_steps_tracker/theme/dimensions.dart';
import 'package:flutter_steps_tracker/utils/constants/constants_keys.dart';
import 'package:flutter_steps_tracker/utils/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pedometer/pedometer.dart';

class BottomNavigationScreen extends ConsumerStatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavigationScreen> createState() =>
      _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends ConsumerState<BottomNavigationScreen>
    with SingleTickerProviderStateMixin {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  final icons = [
    'assets/icons/statistics_icon.svg',
    'assets/icons/redeem_icon.svg'
  ];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    log('$event');
    ref.read(stepsProvider.state).state = event;
    ref.read(updateStepsPointsProvider.notifier).updateStepsPoints();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    log("----- $event");
  }

  void onPedestrianStatusError(error) {
    log('onPedestrianStatusError: $error');
  }

  void onStepCountError(error) {
    log('onStepCountError: $error');
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;

    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        appBarBuilder: (context, tabsRouter) => AppBarWidget(
              // title: 'الإحصائيات',
              titleWidget: Hero(
                tag: ConstantsKeys.logoHeroKey,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fitHeight,
                  width: context.widthR(0.15),
                ),
              ),
            ),
        routes: const [
          DashboardRoute(),
          RedeemingRoute(),
        ],
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          backgroundColor: AppColors.lightBlue,
          child: Padding(
            padding: const EdgeInsets.all(
              AppDimensions.kSizeMedium,
            ),
            child: SvgPicture.asset(
              'assets/icons/redeem_icon.svg',
              color: AppColors.white,
            ),
          ),
          onPressed: () {
            context.pushRoute(const RedeemHistoryRoute());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBuilder: (_, tabsRouter) {
          return AnimatedBottomNavigationBar.builder(
              itemCount: 2,
              tabBuilder: (int index, bool isActive) {
                final color = isActive ? AppColors.lightGreen2 : AppColors.gray;
                return Padding(
                  padding: const EdgeInsets.all(AppDimensions.kSizeMedium),
                  child: SvgPicture.asset(
                    icons[index],
                    color: color,
                  ),
                );
              },
              backgroundColor: AppColors.lightBlue,
              activeIndex: tabsRouter.activeIndex,
              splashColor: AppColors.gray,
              splashSpeedInMilliseconds: 300,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              splashRadius: 10,
              notchSmoothness: NotchSmoothness.smoothEdge,
              notchMargin: 10,
              gapLocation: GapLocation.center,
              onTap: (index) {
                tabsRouter.setActiveIndex(index);
              });
        });
  }
}
