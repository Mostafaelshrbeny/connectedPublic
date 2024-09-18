import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnBoradDescription extends StatelessWidget {
  const OnBoradDescription({
    super.key,
    required this.image,
    required this.label,
  });
  final String image, label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              image,
              height: Device.deviceHeight(context: context, percent: 1 / 3),
              width: Device.deviceWidth(context: context, percent: 1 / 1.5),
              fit: BoxFit.cover,
            ),
          ),
          const Gap(32),
          Text(label, style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          )),
          const Gap(12),
          Text(LocaleKeys.discoveravariety.tr(),
              style: Theme.of(context).textTheme.headlineLarge)
        ],
      ),
    );
  }
}
