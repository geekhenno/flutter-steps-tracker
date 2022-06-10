import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/widgets/image_network_widget.dart';
import 'package:flutter_steps_tracker/theme/colors.dart';
import 'package:flutter_steps_tracker/theme/dimensions.dart';
import 'package:flutter_steps_tracker/utils/extensions.dart';

class PartnersWidget extends StatelessWidget {
  final String? partnerName;
  final String imageUrl;
  final VoidCallback onTap;
  final String? heroTag;
  final String? points;
  final String? date;
  const PartnersWidget(
      {Key? key,
      this.partnerName,
      required this.imageUrl,
      required this.onTap,
      this.points,
      this.date,
      this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (partnerName != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.kSizeMedium,
            ),
            child: Text(
              partnerName!,
              style: context.textTheme.bodyText1,
            ),
          ),
        InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              SizedBox(
                height: context.heightR(0.25),
                width: context.width,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.kDefaultRadius),
                  child: heroTag == null
                      ? ImageNetworkWidget(
                          imageUrl: imageUrl,
                        )
                      : Hero(
                          tag: heroTag!,
                          child: ImageNetworkWidget(
                            imageUrl: imageUrl,
                          ),
                        ),
                ),
              ),
              if (points != null)
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Card(
                    color: AppColors.lightBlue.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.kSizeMedium),
                      child: Column(
                        children: [
                          Text(points!),
                          if (date != null) Text(date!),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
