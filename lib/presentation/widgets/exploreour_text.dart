import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExploreOurCollectionText extends StatelessWidget {
  const ExploreOurCollectionText({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.exploreour.tr(),
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Gap(2),
        Text(
          name,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
        ),
        const Gap(4),
        Text(
          LocaleKeys.collection.tr(),
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
