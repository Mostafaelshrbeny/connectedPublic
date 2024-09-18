import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/AccountPrivacy/account_privacy_cubit.dart';
import 'package:elconnected/presentation/blocs/AccountPrivacy/account_privacy_state.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/textfield_withlabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ChangePasswordFields extends StatefulWidget {
  const ChangePasswordFields({super.key, required this.privacyCubit});
  final AccountPrivacyCubit privacyCubit;

  @override
  State<ChangePasswordFields> createState() => _ChangePasswordFieldsState();
}

class _ChangePasswordFieldsState extends State<ChangePasswordFields> {
  final GlobalKey<FormState> fKey = GlobalKey();
  TextEditingController oldpassCon = TextEditingController();
  TextEditingController newpassCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountPrivacyCubit, AccountPrivacyState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Stack(
            children: [
              Form(
                key: fKey,
                child: Column(
                  children: [
                    TextFieldWithLabel(
                      controller: oldpassCon,
                      validate: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'This Field is required';
                        } else {
                          return null;
                        }
                      },
                      label: LocaleKeys.currentPassword.tr(),
                      hidden: widget.privacyCubit.oldpasswordHidden,
                      suffix: IconButton(
                        onPressed: () {
                          widget.privacyCubit.oldpasswordVisibility();
                        },
                        icon: Icon(
                          widget.privacyCubit.oldpasswordHidden
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Gap(16),
                    TextFieldWithLabel(
                      controller: newpassCon,
                      validate: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'This Field is required';
                        } else {
                          return null;
                        }
                      },
                      label: LocaleKeys.newPassword.tr(),
                      hidden: widget.privacyCubit.newpasswordHidden,
                      suffix: IconButton(
                        onPressed: () {
                          widget.privacyCubit.newpasswordVisibility();
                        },
                        icon: Icon(
                          widget.privacyCubit.newpasswordHidden
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Gap(16),
                    TextFieldWithLabel(
                      validate: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'This Field is required';
                        } else if (p0 != newpassCon.text) {
                          return 'Not Matching';
                        }
                        return null;
                      },
                      label: LocaleKeys.confirmNewPassword.tr(),
                      hidden: widget.privacyCubit.confirmpasswordHidden,
                      suffix: IconButton(
                        onPressed: () {
                          widget.privacyCubit.confirmpasswordVisibility();
                        },
                        icon: Icon(
                          widget.privacyCubit.confirmpasswordHidden
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppCustomButton(
                  buttonChild: Text(
                    LocaleKeys.changePassword.tr(),
                    style: AppThemeData.buttonTextThem(context),
                  ),
                  ontap: () {
                    if (fKey.currentState!.validate()) {
                      AccountPrivacyCubit.get(context).updatePassword(
                          oldPassword: oldpassCon.text,
                          newPassword: newpassCon.text);
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
