import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/theme/colors.dart';
import 'package:flutter_steps_tracker/theme/dimensions.dart';
import 'package:flutter_steps_tracker/utils/extensions.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color titleColor;
  final Color disabledColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color disabledBackground;
  final double shapeRadius;
  final double horizontalPadding;
  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.titleColor = AppColors.primary,
    this.disabledColor = AppColors.gray,
    this.backgroundColor = AppColors.white,
    this.borderColor = Colors.transparent,
    this.disabledBackground = AppColors.gray,
    this.shapeRadius = AppDimensions.kSmallRadius,
    this.horizontalPadding = AppDimensions.kSizeLarge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: AppDimensions.kSizeSmall,
        )),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return backgroundColor.withOpacity(0.7);
            } else if (states.contains(MaterialState.disabled)) {
              return disabledBackground;
            }
            return backgroundColor;
          },
        ),
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(shapeRadius));
            }
            return RoundedRectangleBorder(
                side: BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(shapeRadius));
          },
        ),
      ),
      child: Text(
        title,
        style: context.textTheme.button
            ?.copyWith(color: onPressed == null ? disabledColor : titleColor),
      ),
    );
  }
}
