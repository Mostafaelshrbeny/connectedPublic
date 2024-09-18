import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PinkAdCard extends StatelessWidget {
  const PinkAdCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 16),
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? Device.deviceHeight(context: context, percent: 1 / 10)
              : Device.deviceHeight(context: context, percent: 1 / 3.8),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(246, 0, 125, 1),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                    ? Device.deviceHeight(context: context, percent: 1 / 10)
                    : Device.deviceHeight(context: context, percent: 1 / 3.8),
                width: Device.deviceWidth(context: context, percent: 1 / 3.5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.horizontal(
                        start: Radius.circular(16)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/Group 20.png"),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(246, 0, 125, 1),
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.white,
                        ),
                        Gap(8.w),
                        Text(
                          '16:17',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("${LocaleKeys.saveupto.tr()} 70%",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white)),
                    const Gap(4),
                    Text("Limited time offer on Smartphones",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
