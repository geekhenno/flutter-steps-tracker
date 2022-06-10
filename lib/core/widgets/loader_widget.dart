import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/theme/colors.dart';

class LoaderWidget extends StatelessWidget {
  final Color color;

  const LoaderWidget({Key? key, this.color = AppColors.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            color: Colors.transparent,
            height: 50,
            width: 50,
            child: const CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.white)));
  }
}
