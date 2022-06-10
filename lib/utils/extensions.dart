import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// *** Extensions on BuildContext class ***
extension SugarExt on BuildContext {
// Widgets Extensions
  void showAlertDialog(Widget widget) =>
      showDialog(context: this, builder: (context) => widget);

  // MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  //* Dimensions Extensions
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double heightR(double value) => mediaQuery.size.height * value;
  double widthR(double value) => mediaQuery.size.width * value;
  double defaultSize() {
    if (mediaQuery.orientation == Orientation.landscape) {
      return height * 0.024;
    } else {
      return width * 0.024;
    }
  }

  bool get isScreenReaderActive => mediaQuery.accessibleNavigation;

  // Device Breakpoints
  bool get isMobile => width <= 600;
  bool get isTablet => width > 600;
  bool get isDesktop => width > 950;
  bool get isLargeMobile => isMobile && height > 800;
  bool get isSmallMobile => isMobile && height < 550;

  // Locale Extensions
  bool get isRTL =>
      Bidi.isRtlLanguage(Localizations.localeOf(this).languageCode);

  // Theme Extensions
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // Request UnFocus
  void unFocusRequest() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

/// *** Extensions on Color class ***
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
