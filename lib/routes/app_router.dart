import 'package:auto_route/auto_route.dart';
import 'package:flutter_steps_tracker/features/authentication/presentation/screens/user_login_screen.dart';
import 'package:flutter_steps_tracker/features/bottom_navigation/presentation/screens/bottom_navigation_screen.dart';
import 'package:flutter_steps_tracker/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter_steps_tracker/features/redeeming/presentation/screens/redeem_history.dart';
import 'package:flutter_steps_tracker/features/redeeming/presentation/screens/redeeming_details_screen.dart';
import 'package:flutter_steps_tracker/features/redeeming/presentation/screens/redeeming_screen.dart';
import 'package:flutter_steps_tracker/features/splash/presentation/screens/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    CustomRoute(
        page: UserLoginScreen,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 400),
    CustomRoute(
      page: BottomNavigationScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 400,
      children: [
        AutoRoute(page: DashboardScreen),
        AutoRoute(page: RedeemingScreen),
      ],
    ),
    AutoRoute(page: RedeemingDetailsScreen),
    AutoRoute(page: RedeemHistoryScreen),
  ],
)
class $AppRouter {}
