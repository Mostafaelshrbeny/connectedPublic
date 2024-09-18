import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RowTextLabel extends StatelessWidget {
  const RowTextLabel({
    super.key,
    required this.label,
    this.ontap,
    this.endPadding = true,
  });
  final String label;
  final Function()? ontap;
  final bool endPadding;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const Spacer(),
        InkWell(
          onTap: ontap,
          child: Row(
            children: [
              Text(
                LocaleKeys.seeall.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: AppThemeData.appBlue),
              ),
              const Gap(8),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppThemeData.appBlue),
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.all(1),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppThemeData.appBlue,
                  size: 12,
                ),
              ),
            ],
          ),
        ),
        Gap(endPadding ? 16 : 0),
      ],
    );
  }
}
