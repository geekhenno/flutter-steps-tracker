import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_steps_tracker/routes/app_router.gr.dart';
import 'package:flutter_steps_tracker/theme/app_theme.dart';
import 'package:flutter_steps_tracker/utils/extensions.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter());

class App extends ConsumerStatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/localization',
      saveLocale: true,
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            context.unFocusRequest();
          },
          child: Consumer(builder: (context, ref, _) {
            final router = ref.read(appRouterProvider);
            //* Watch app event bus provider to keep it alive as long as the app is on
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              // showSemanticsDebugger: true,
              title: "Mabsout",
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              builder: (context, navigator) {
                // Update scale for text
                final scale =
                    context.mediaQuery.textScaleFactor.clamp(0.8, 1.0);

                return Builder(
                  builder: (context) {
                    return MediaQuery(
                      data: context.mediaQuery.copyWith(textScaleFactor: scale),
                      child: MyAppTheme(
                        navigator: navigator,
                      ),
                    );
                  },
                );
              },

              routerDelegate: AutoRouterDelegate(
                router,
              ),
              routeInformationParser: router.defaultRouteParser(),
            );
          }),
        ),
      ),
    ));
  }
}
