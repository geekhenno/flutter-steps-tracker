import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/widgets/loader_widget.dart';
import 'package:flutter_steps_tracker/theme/colors.dart';
import 'package:flutter_steps_tracker/theme/dimensions.dart';
import 'package:flutter_steps_tracker/utils/constants/enums.dart';
import 'package:flutter_steps_tracker/utils/extensions.dart';
import 'package:overlay_support/overlay_support.dart';

// ignore_for_file: avoid_classes_with_only_static_members
///
/// Contains useful functions to reduce boilerplate code
///
///

class UiHelper {
  //* <--------------------- Notifications State
  static String _notificationMessage = '';

  // radius border values

  static const double _smallBorderRadius = 4.0;
  static const double _mediumBorderRadius = 8.0;
  static const double _radiusLarge = 16.0;
  static const double _radiusXLarge = 32.0;

  // Actual device screen size

  //* <---------------------------------------------------------  Border Radius
  /// Radius Boders

  static double get defaultRadius => _radiusLarge;

  static BorderRadius xLargeBorderRadius() {
    return const BorderRadius.all(Radius.circular(_radiusXLarge));
  }

  static BorderRadius largeBorderRadius() {
    return const BorderRadius.all(Radius.circular(_radiusLarge));
  }

  static BorderRadius mediumBorderRadius() {
    return const BorderRadius.all(Radius.circular(_mediumBorderRadius));
  }

  static BorderRadius smallBorderRadius() {
    return const BorderRadius.all(Radius.circular(_smallBorderRadius));
  }

  // Custom Methods
  static BorderRadius allRoundedEdges([double radius = _radiusLarge]) {
    return BorderRadius.all(Radius.circular(radius));
  }

  static BorderRadius topRoundedEdges([double radius = _radiusLarge]) {
    return BorderRadius.only(
        topLeft: Radius.circular(radius), topRight: Radius.circular(radius));
  }

  static BorderRadius bottomRoundedEdges([double radius = _radiusLarge]) {
    return BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius));
  }

  static BorderRadius rightRoundedEdges([double radius = _radiusLarge]) {
    return BorderRadius.only(
        bottomRight: Radius.circular(radius),
        topRight: Radius.circular(radius));
  }

  static BorderRadius leftRoundedEdges([double radius = _radiusLarge]) {
    return BorderRadius.only(
        topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius));
  }

  static BorderRadius topRightRoundedEdge([double radius = _radiusLarge]) {
    return BorderRadius.only(topRight: Radius.circular(radius));
  }

  static BorderRadius topLeftRoundedEdge([double radius = _radiusLarge]) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius),
    );
  }

  static BorderRadius bottomLeftRoundedEdge([double radius = _radiusLarge]) {
    return BorderRadius.only(
      bottomLeft: Radius.circular(radius),
    );
  }

  static BorderRadius bottomRightRoundedEdge([double radius = _radiusLarge]) {
    return BorderRadius.only(
      bottomRight: Radius.circular(radius),
    );
  }

  //* <------------------------------------------------  Text Fieald Decoration
  /// Outline Border
  static InputBorder get noBorder => const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      );

  static OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.kSizeSmall),
      borderSide: const BorderSide(color: Color(0xFFECECEF)));
  //* <-------------------------------------------------- Shadow
  static List<BoxShadow> shadow({
    double spreadRadius = 1,
    double blurRadius = 3,
    Offset offset = const Offset(0, 2),
  }) =>
      [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: spreadRadius,
          blurRadius: blurRadius,
          offset: offset, // changes position of shadow
        ),
      ];

  //* <--------------------------------------------------- Gradient

  //* <------------------------------------------------ Notification & Messages

// Show Notification
  static void showNotification(
    String message, {
    NotificationPosition? position,
    int durationInSeconds = 3,
    NotificationType notificationType = NotificationType.fail,
  }) {
    if (_notificationMessage != message) {
      _notificationMessage = message;
      showOverlayNotification(
        (context) => Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16, vertical: context.heightR(0.15)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            color: notificationType == NotificationType.fail
                ? AppColors.red
                : AppColors.primary,
            boxShadow: const [
              BoxShadow(
                color: Color(0x4c000000),
                offset: Offset(0, 7),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.kSizeLarge),
            child: Center(
              child: Text(
                message,
                style:
                    context.textTheme.bodyText1!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        duration: Duration(seconds: durationInSeconds),
        position: position ?? NotificationPosition.top,
      ).dismissed.then((value) {
        _notificationMessage = '';
      });
    }
  }

  // Show Alert Dialog
  static void showSimpleAlertDialog(
      {required BuildContext context,
      required VoidCallback action,
      required String message,
      required String okButtonText,
      required String cancelButtonText}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Text(
          message,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              cancelButtonText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          TextButton(
            onPressed: action,
            child: Text(okButtonText,
                style: Theme.of(context).textTheme.subtitle2),
          ),
        ],
      ),
    );
  }

  //show loading dialog
  static void showLoadingDialog(context) {
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (context) => const AlertDialog(
        title: LoaderWidget(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  //* <----------------------------------------- Functions & Extensions
  // Post Frame Callbacks
  static void postBuildCallback(void Function(Duration) callback) {
    WidgetsBinding.instance.addPostFrameCallback(callback);
  }
} // Class UiHelper
