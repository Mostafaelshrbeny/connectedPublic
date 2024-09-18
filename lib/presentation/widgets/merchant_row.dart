import 'package:cached_network_image/cached_network_image.dart';
import 'package:elconnected/constant/device.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MerchantRow extends StatelessWidget {
  const MerchantRow(
      {super.key,
      required this.image,
      required this.name,
      required this.catergory,
      required this.categoryImage,
      required this.rating,
      required this.ratingNumber});
  final String image, name, catergory, categoryImage;
  final String rating;
  final String ratingNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Container(
            height: Device.deviceWidth(context: context, percent: 1 / 6),
            width: Device.deviceWidth(context: context, percent: 1 / 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
          errorWidget: (context, url, error) => const SizedBox(),
          placeholder: (context, url) => const SizedBox(),
        ),
        const Gap(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name, style: Theme.of(context).textTheme.headlineLarge),
            const Gap(6),
            Text(catergory,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.grey)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rate_rounded,
                    size: 15.5, color: Color.fromRGBO(217, 179, 61, 1)),
                const Gap(4),
                Text(rating.toString(),
                    style: Theme.of(context).textTheme.headlineSmall),
                const Gap(4),
                Text("($ratingNumber Ratings)",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.grey))
              ],
            ),
          ],
        ),
        const Spacer(),
        CachedNetworkImage(
          imageUrl: categoryImage,
          imageBuilder: (context, imageProvider) => Image(
            image: imageProvider,
            height: Device.deviceWidth(context: context, percent: 1 / 6),
            width: Device.deviceWidth(context: context, percent: 1 / 6),
          ),
          errorWidget: (context, url, error) => const SizedBox(),
          placeholder: (context, url) => const SizedBox(),
        )
      ],
    );
  }
}
