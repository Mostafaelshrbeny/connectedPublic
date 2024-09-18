import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/ManageAccount/manage_account_cubit.dart';
import 'package:elconnected/presentation/blocs/ManageAccount/manage_account_state.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/textfield_withlabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DeleteAccountWidgets extends StatelessWidget {
  const DeleteAccountWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordCon = TextEditingController();
    GlobalKey<FormState> fKey = GlobalKey();
    return BlocConsumer<ManageAccountCubit, ManageAccountState>(
      listener: (context, state) {
        if (state is DeleteDoneState) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.authRoute, (route) => false);
        }
      },
      builder: (context, state) {
        return Form(
          key: fKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.afterDeleting.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Gap(12),
                Text(
                  "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure,",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.grey),
                ),
                const Gap(32),
                TextFieldWithLabel(
                  fillColor: const Color.fromRGBO(249, 250, 251, 1),
                  validate: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'This Field is required';
                    } else {
                      return null;
                    }
                  },
                  controller: passwordCon,
                  hidden: ManageAccountCubit.get(context).passwordHidden,
                  label: LocaleKeys.password.tr(),
                  suffix: IconButton(
                      onPressed: () {
                        ManageAccountCubit.get(context).showPassword();
                      },
                      icon: Icon(
                        ManageAccountCubit.get(context).passwordHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey.withOpacity(0.6),
                      )),
                ),
                const Gap(32),
                ManageAccountCubit.get(context).loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : AppCustomButton(
                        buttonChild: Text(
                          LocaleKeys.deleteAccount.tr(),
                          style: AppThemeData.buttonTextThem(context),
                        ),
                        ontap: () {
                          if (fKey.currentState!.validate()) {
                            ManageAccountCubit.get(context)
                                .deleteAccount(password: passwordCon.text);
                          }
                        },
                        backgroundColor: Colors.red,
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
