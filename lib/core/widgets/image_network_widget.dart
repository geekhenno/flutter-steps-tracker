import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final Color? imageColor;
  final double? height;
  final BoxFit? boxFit;

  const ImageNetworkWidget(
      {Key? key,
      required this.imageUrl,
      this.imageColor,
      this.height,
      this.boxFit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageUrl,
      colorBlendMode: BlendMode.color,
      fit: BoxFit.cover,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Shimmer.fromColors(
              baseColor: AppColors.lightBlue,
              highlightColor: AppColors.blue,
              direction: ShimmerDirection.rtl,
              period: const Duration(milliseconds: 1000),
              child: Container(color: Colors.grey[50]),
            );

          case LoadState.completed:
            return state.completedWidget;

          default:
            return Card(
              child: Image.asset('assets/images/logo.png'),
            );
        }
      },
    );
  }
}
