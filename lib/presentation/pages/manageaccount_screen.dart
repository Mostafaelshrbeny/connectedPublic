import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/ManageAccount/manage_account_cubit.dart';
import 'package:elconnected/presentation/blocs/ManageAccount/manage_account_state.dart';
import 'package:elconnected/presentation/widgets/delete_account_widgets.dart';
import 'package:elconnected/presentation/widgets/manage_accountwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageAccountCubit(),
      child: BlocConsumer<ManageAccountCubit, ManageAccountState>(
        listener: (context, state) {},
        builder: (context, state) {
          ManageAccountCubit manageCubit = ManageAccountCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  manageCubit.deletingAccount
                      ? LocaleKeys.deleteAccount.tr()
                      : LocaleKeys.manageAccount.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      manageCubit.deletingAccount
                          ? manageCubit.switchToDelete()
                          : Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppThemeData.appBlue,
                    )),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                child: manageCubit.deletingAccount
                    ? const DeleteAccountWidgets()
                    : ManageAccountWidgets(
                        manageCubit: manageCubit,
                      ),
              ));
        },
      ),
    );
  }
}
