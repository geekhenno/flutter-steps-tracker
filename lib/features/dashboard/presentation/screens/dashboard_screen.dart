import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/widgets/bar_chart_widget.dart';
import 'package:flutter_steps_tracker/core/widgets/button_widget.dart';
import 'package:flutter_steps_tracker/core/widgets/loader_widget.dart';
import 'package:flutter_steps_tracker/features/bottom_navigation/application/steps_provider.dart';
import 'package:flutter_steps_tracker/features/dashboard/application/dashboard_provider.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:flutter_steps_tracker/services/firebase/firebase_client.dart';
import 'package:flutter_steps_tracker/theme/dimensions.dart';
import 'package:flutter_steps_tracker/utils/extensions.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(dashboardProvider.notifier).getUserDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);
    if (state is LoadingViewState) {
      return const LoaderWidget();
    }

    if (state is LoadedViewState<List<DashboardEntity>>) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.kSizeMedium,
              vertical: AppDimensions.kSizeLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(
                              AppDimensions.kSizeXLarge,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'عدد الخطوات اليوم',
                                  style: context.textTheme.bodyLarge,
                                ),
                                Text(
                                  ref.watch(stepsProvider)?.steps.toString() ??
                                      '0',
                                  style: context.textTheme.headline5,
                                ),
                              ],
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: AppDimensions.kSizeSmall,
                    ),
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: AppDimensions.kSizeMedium),
                        child: Padding(
                            padding: const EdgeInsets.all(
                              AppDimensions.kSizeXLarge,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'النقاط المكتسبة اليوم',
                                  style: context.textTheme.bodyLarge,
                                ),
                                Text(
                                  ref.watch(pointsProvider).toString(),
                                  style: context.textTheme.headline5,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: AppDimensions.kSizeMedium),
                  child: Padding(
                      padding: const EdgeInsets.all(
                        AppDimensions.kSizeXLarge,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'الخطوات من بداية تحميل التطبيق',
                            style: context.textTheme.bodyLarge,
                          ),
                          Text(
                            ref
                                .read(dashboardProvider.notifier)
                                .totalSteps()
                                .toString(),
                            style: context.textTheme.headline5,
                          ),
                        ],
                      )),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: AppDimensions.kSizeMedium),
                  child: Padding(
                      padding: const EdgeInsets.all(
                        AppDimensions.kSizeXLarge,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'النقاط المكتسبة من بداية تحميل التطبيق',
                            style: context.textTheme.bodyLarge,
                          ),
                          Text(
                            ref
                                .read(dashboardProvider.notifier)
                                .totalPoints()
                                .toString(),
                            style: context.textTheme.headline5,
                          ),
                        ],
                      )),
                ),
                if (state.data.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.kSizeLarge),
                    child: BarChartWidget(steps: state.data.take(7).toList()),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
