import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/ManageAccount/manage_account_cubit.dart';
import 'package:elconnected/presentation/pages/authenticationscreen.dart';
import 'package:elconnected/presentation/widgets/accountoption_row.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManageAccountWidgets extends StatelessWidget {
  const ManageAccountWidgets({super.key, required this.manageCubit});
  final ManageAccountCubit manageCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountoptionRow(
          option: LocaleKeys.deleteAccount.tr(),
          withSuffix: true,
          nextScreenRoute: () {
            manageCubit.switchToDelete();
          },
          prefixIcon: Icon(
            Icons.person_off,
            color: AppThemeData.appBlue,
          ),
        ),
        const Gap(40),
        AppCustomButton(
            backgroundColor: Colors.white,
            borderColor: Colors.red,
            buttonChild: Text(LocaleKeys.logout.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.red)),
            ontap: () async {
              await HiveLocaleData.myAppBox!.clear();

              LocalePref.prefs!
                  .remove("token")
                  .then((val) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const AuthScreen()),
                        (route) => false,
                      ));

              HiveLocaleData.myAppBox?.put("inApp", false);
            })
      ],
    );
  }
}
