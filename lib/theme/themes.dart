import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/theme/colors.dart';

import 'dimensions.dart';

ThemeData getThemeData() {
  // ThemeData
  return ThemeData(
    // <------------------------------------------------ Main Theme Font
    fontFamily: 'Jannat',
    primarySwatch: createMaterialColor(AppColors.primary),
    primaryColor: AppColors.primary,
    secondaryHeaderColor: AppColors.white,
    backgroundColor: AppColors.white,
    cardColor: AppColors.blue,
    scaffoldBackgroundColor: AppColors.primary,
    bottomAppBarColor: AppColors.blue,
    dividerColor: AppColors.black.withOpacity(0.10),
    disabledColor: Colors.grey,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.blue,
    ),

    // <------------------------------------------------ Primary Icon Theme
    primaryIconTheme: const IconThemeData(color: AppColors.white),

    // <------------------------------------------------ Icon Theme
    iconTheme: const IconThemeData(color: AppColors.lightBlue),

    // <------------------------------------------------ Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.blue,
      //labelStyle: ,
      unselectedLabelColor: AppColors.blue,
      indicator: BoxDecoration(
        color: Colors.blue.withOpacity(0.6),
      ),
    ),
    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.kMediumRadius))),
    // <------------------------------------------------ FAB Theme

    // <------------------------------------------------ App Bar Theme Theme
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        shadowColor: AppColors.black.withOpacity(0.5)),

    // <------------------------------------------------ Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.kSizeLarge,
          vertical: AppDimensions.kSizeSmall),
      fillColor: AppColors.white,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.kSizeSmall),
          borderSide: BorderSide(color: AppColors.white.withOpacity(0.7))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.kSizeSmall),
          borderSide: const BorderSide(color: AppColors.white)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.kSizeSmall),
          borderSide: const BorderSide(color: AppColors.white)),
      labelStyle: const TextStyle(
        fontSize: AppDimensions.kSizeMedium,
        color: AppColors.white,
      ),
      hintStyle: const TextStyle(
        fontSize: AppDimensions.kSizeLarge,
        color: AppColors.lightBlue,
      ),
    ),

    // <------------------------------------------------ Text Theme
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: AppColors.white),
      bodyText2: TextStyle(color: AppColors.white),
      button: TextStyle(color: AppColors.white),
      caption: TextStyle(color: AppColors.white),
      subtitle1: TextStyle(color: AppColors.primary), // ==> text field style
      headline1: TextStyle(color: AppColors.white),
      headline2: TextStyle(color: AppColors.white),
      headline3: TextStyle(color: AppColors.white),
      headline4: TextStyle(color: AppColors.white),
      headline5: TextStyle(color: AppColors.white),
      headline6: TextStyle(color: AppColors.white),
    ),
  );
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
