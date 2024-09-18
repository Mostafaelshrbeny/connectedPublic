import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OnBoradBottomRow extends StatelessWidget {
  const OnBoradBottomRow({
    super.key,
    required this.progress,
    required this.ontap,
  });
  final double progress;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 42),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.authRoute);
              },
              child: Text(LocaleKeys.skip.tr(),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppThemeData.appBlue,
                      fontWeight: FontWeight.w800)),
            ),
            const Spacer(),
            StatefulBuilder(
              builder: (context, setState) => InkWell(
                onTap: ontap,
                child: CircularPercentIndicator(
                  radius: 29,
                  progressColor: AppThemeData.appBlue,
                  percent: progress,
                  center: CircleAvatar(
                    backgroundColor: AppThemeData.appBlue,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
