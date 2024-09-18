import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/widgets/accountoption_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.settings.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            AccountoptionRow(
              option: LocaleKeys.privay.tr(),
              withSuffix: true,
              nextScreenRoute: () {
                Navigator.pushNamed(context, Routes.privacyRoute);
              },
              prefixIcon: Icon(
                Icons.verified_user,
                color: AppThemeData.appBlue,
                size: 20,
              ),
            ),
            const Gap(32),
            AccountoptionRow(
              option: LocaleKeys.notifications.tr(),
              withSuffix: true,
              nextScreenRoute: () {
                Navigator.pushNamed(context, Routes.notificationsettingRoute);
              },
              prefixIcon: Icon(
                Icons.notifications,
                color: AppThemeData.appBlue,
                size: 20,
              ),
            ),
            const Gap(32),
            AccountoptionRow(
              option: LocaleKeys.manageAccount.tr(),
              withSuffix: true,
              nextScreenRoute: () {
                Navigator.pushNamed(context, Routes.manageAccountRoute);
              },
              prefixIcon: Icon(
                Icons.account_circle,
                color: AppThemeData.appBlue,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
