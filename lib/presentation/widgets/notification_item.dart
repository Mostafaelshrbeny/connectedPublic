import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.image,
  });
  final String title, message, timeAgo, image;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Spacer(),
            Text(
              timeAgo,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
        const Gap(8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            const Gap(20),
            CachedNetworkImage(
              imageUrl: image,
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              errorWidget: (context, url, error) => const SizedBox(),
              placeholder: (context, url) => const SizedBox(),
            )
          ],
        ),
        const Gap(16),
        // AppCustomButton(
        //   buttonChild: Text(
        //     LocaleKeys.bidswordplaceahigherbid.tr(),
        //     style: AppThemeData.buttonTextThem(context),
        //   ),
        //   ontap: () {},
        //   buttonWidth: Device.deviceWidth(context: context, percent: 1 / 2.5),
        //   heightPercent: 1 / 20,
        // ),
        const Gap(12),
        const Divider(color: Colors.grey, thickness: 0.3),
      ],
    );
  }
}
