import 'package:elconnected/constant/device.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AccountoptionRow extends StatelessWidget {
  const AccountoptionRow(
      {super.key,
      required this.option,
      this.suffixIcon,
      this.prefixIcon,
      required this.withSuffix,
      required this.nextScreenRoute});
  final String option;
  final Widget? suffixIcon, prefixIcon;
  final bool withSuffix;
  final Function()? nextScreenRoute;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: nextScreenRoute,
      child: Row(
        children: [
          SizedBox(
            height: Device.deviceHeight(context: context, percent: 1 / 20),
          ),
          prefixIcon ?? const SizedBox(),
          const Gap(12),
          Text(option, style: Theme.of(context).textTheme.headlineMedium),
          const Spacer(),
          withSuffix
              ? suffixIcon ??
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.withOpacity(0.5),
                    size: 18,
                  )
              : const SizedBox()
        ],
      ),
    );
  }
}
