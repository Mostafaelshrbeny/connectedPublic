import 'package:cached_network_image/cached_network_image.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class OwnerInfo extends StatelessWidget {
  const OwnerInfo({
    super.key,
    required this.ownerRole,
    required this.ownerName,
    required this.actionText,
    required this.actionurl,
    required this.imageUrl,
  });
  final String ownerRole, ownerName, actionText, actionurl, imageUrl;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ownerRole, style: Theme.of(context).textTheme.headlineMedium),
            const Gap(8),
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 12,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(image: imageProvider)),
                    ),
                  ),
                  errorWidget: (context, url, error) => const SizedBox(),
                  placeholder: (context, url) => const SizedBox(),
                ),
                Text(ownerName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.grey))
              ],
            )
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            launchUrl(
              Uri.parse(actionurl),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(actionText,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: AppThemeData.appBlue)),
              const Gap(4),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppThemeData.appBlue,
              )
            ],
          ),
        )
      ],
    );
  }
}
