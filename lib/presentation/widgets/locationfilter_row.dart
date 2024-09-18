import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LocationsFilterRow extends StatelessWidget {
  const LocationsFilterRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.locations.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
            const Gap(2),
            Text(
              "Cairo,Egypt",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(LocaleKeys.seelocations.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: AppThemeData.appBlue)),
            const Gap(4),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppThemeData.appBlue,
              size: 14,
            )
          ],
        )
      ],
    );
  }
}
