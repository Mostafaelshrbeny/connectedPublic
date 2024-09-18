import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignInLaterDialog {
  static signInDialog(BuildContext context, Function() ontap) {
    return showAdaptiveDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: Device.deviceHeight(context: context, percent: 1 / 4),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(LocaleKeys.needToSign.tr(),
                    style: Theme.of(context).textTheme.headlineLarge),
                const Gap(20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () {
                          ontap();
                          Navigator.pop(context);
                        },
                        child: Text(LocaleKeys.cancel.tr(),
                            style: Theme.of(context).textTheme.headlineSmall)),
                    const Gap(10),
                    TextButton(
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.authRoute,
                              (route) => false,
                            ),
                        child: Text(LocaleKeys.signin.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: AppThemeData.appBlue))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
