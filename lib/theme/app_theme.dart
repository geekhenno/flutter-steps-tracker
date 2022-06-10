import 'package:flutter/material.dart';

import 'themes.dart';

class MyAppTheme extends StatelessWidget {
  final Widget? navigator;

  const MyAppTheme({Key? key, required this.navigator}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getThemeData(), //     <-----     Theme
      child: navigator!,
    );
  }
}
