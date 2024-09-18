import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/AccountPrivacy/account_privacy_cubit.dart';
import 'package:elconnected/presentation/blocs/AccountPrivacy/account_privacy_state.dart';
import 'package:elconnected/presentation/widgets/accountoption_row.dart';
import 'package:elconnected/presentation/widgets/changepassword_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountPrivacyCubit(),
      child: BlocConsumer<AccountPrivacyCubit, AccountPrivacyState>(
        listener: (context, state) {},
        builder: (context, state) {
          AccountPrivacyCubit privacyCubit = AccountPrivacyCubit.get(context);
          return GestureDetector(
            onTap: () => Device.closeKeyboard(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                  privacyCubit.changePassword
                      ? LocaleKeys.changePassword.tr()
                      : LocaleKeys.privay.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      privacyCubit.changePassword
                          ? privacyCubit.startChangingPassword()
                          : Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppThemeData.appBlue,
                    )),
              ),
              body: !privacyCubit.changePassword
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 22),
                      child: AccountoptionRow(
                        option: LocaleKeys.changePassword.tr(),
                        withSuffix: true,
                        nextScreenRoute: () {
                          privacyCubit.startChangingPassword();
                        },
                        prefixIcon: FaIcon(
                          FontAwesomeIcons.key,
                          color: AppThemeData.appBlue,
                          size: 18,
                        ),
                      ),
                    )
                  : ChangePasswordFields(
                      privacyCubit: privacyCubit,
                    ),
            ),
          );
        },
      ),
    );
  }
}
