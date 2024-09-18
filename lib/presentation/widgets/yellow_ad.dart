import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class YellowAdBox extends StatelessWidget {
  const YellowAdBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 16),
      width: double.infinity,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? Device.deviceHeight(context: context, percent: 1 / 7)
          : Device.deviceHeight(context: context, percent: 1 / 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromRGBO(212, 252, 0, 1)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? Device.deviceHeight(context: context, percent: 1 / 7)
                        : Device.deviceHeight(context: context, percent: 1 / 4),
                width: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                    ? Device.deviceHeight(context: context, percent: 1 / 4.5)
                    : Device.deviceHeight(context: context, percent: 1 / 3),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/brandon-griggs-wR11KBaB86U-unsplash-removebg-preview 1.png'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadiusDirectional.horizontal(
                        end: Radius.circular(16)),
                    color: Color.fromRGBO(212, 252, 0, 1))),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 12.h, left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.bookyourunitNOW.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Gap(4),
                  Text(
                    "10% Down Payment",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.grey),
                  ),
                  const Gap(4),
                  Text(
                    "96 Monthly Installments",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.grey),
                  ),
                  const Gap(4),
                  Text(
                    "3,500,000",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
