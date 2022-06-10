import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/features/authentication/application/auth_provider.dart';
import 'package:flutter_steps_tracker/routes/app_router.gr.dart';
import 'package:flutter_steps_tracker/utils/constants/constants_keys.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 2000), () {
      ref.read(authProvider.notifier).isSignIn().then((value) {
        if (value) {
          context.replaceRoute(const BottomNavigationRoute());
          return;
        }
        context.replaceRoute(const UserLoginRoute());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Hero(
              tag: ConstantsKeys.logoHeroKey,
              child: Image.asset('assets/images/logo.png'))),
    );
  }
}
