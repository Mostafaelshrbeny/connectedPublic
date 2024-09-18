import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/AuthenticationCubit/authentication_cubit.dart';
import 'package:elconnected/presentation/blocs/AuthenticationCubit/authentication_state.dart';
import 'package:elconnected/presentation/blocs/SignInCubit/sign_in_cubit.dart';
import 'package:elconnected/presentation/blocs/SignInCubit/sign_in_state.dart';
import 'package:elconnected/presentation/blocs/VerifyCubit/verification_cubit.dart';
import 'package:elconnected/presentation/pages/verifyscreen.dart';
import 'package:elconnected/presentation/widgets/authtextrich.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/textfield_withlabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> fKey = GlobalKey();
    TextEditingController emailCon = TextEditingController();
    TextEditingController passwordCon = TextEditingController();
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () => Device.closeKeyboard(),
          child: Form(
            key: fKey,
            child: SizedBox(
              height: Device.deviceHeight(context: context, percent: 1 / 1.35),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(30),
                    Text(
                      LocaleKeys.signin.tr(),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                    ),
                    const Gap(8),
                    AuthTextRich(
                      firstlabel: LocaleKeys.donthaveaccount.tr(),
                      secondlabel: LocaleKeys.createaccount.tr(),
                      secondPage: 1,
                    ),
                    const Gap(32),
                    TextFieldWithLabel(
                      action: TextInputAction.next,
                      fillColor: const Color.fromRGBO(249, 250, 251, 1),
                      inputType: TextInputType.emailAddress,
                      validate: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'This Field is required';
                        } else {
                          return null;
                        }
                      },
                      controller: emailCon,
                      label: LocaleKeys.email.tr(),
                    ),
                    const Gap(24),
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
                      hidden: AuthenticationCubit.get(context).passwordHidden,
                      label: LocaleKeys.password.tr(),
                      suffix: IconButton(
                          onPressed: () {
                            AuthenticationCubit.get(context).showPassword();
                          },
                          icon: Icon(
                            AuthenticationCubit.get(context).passwordHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.grey.withOpacity(0.6),
                          )),
                    ),
                    // const Gap(4),
                    const Gap(32),
                    BlocProvider(
                      create: (context) => SignInCubit(),
                      child: BlocConsumer<SignInCubit, SignInState>(
                        listener: (context, state) {
                          if (state is SignInDoneState) {
                            SignInCubit.get(context).verified
                                ? {
                                    Navigator.pushNamed(
                                        context, Routes.mainLayerRoute),
                                    HiveLocaleData.myAppBox?.put('inApp', true)
                                  }
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider(
                                          create: (context) =>
                                              VerificationCubit(),
                                          child: VerifyScreen(
                                              seconds: SignInCubit.get(context)
                                                      .second ??
                                                  0)),
                                    ));
                          } else if (state is SignInFailedState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                SignInCubit.get(context).errorMsg ??
                                    "Something Went Wrong",
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            ));
                          }
                        },
                        builder: (context, state) {
                          return SignInCubit.get(context).loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppThemeData.appBlue,
                                  ),
                                )
                              : AppCustomButton(
                                  buttonChild: Text(
                                    LocaleKeys.signin.tr(),
                                    style: AppThemeData.buttonTextThem(context),
                                  ),
                                  ontap: () {
                                    if (fKey.currentState!.validate()) {
                                      SignInCubit.get(context).userlogin(
                                        email: emailCon.text,
                                        password: passwordCon.text,
                                      );
                                    }
                                  },
                                );
                        },
                      ),
                    ),
                    const Gap(15),
                    // Align(
                    //   alignment: AlignmentDirectional.centerEnd,
                    //   child: Text(LocaleKeys.forgotPassword.tr(),
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .headlineSmall!
                    //           .copyWith(color: AppThemeData.appBlue)),
                    // ),
                    // const Gap(42),
                    // const TextBetweenDividers(),
                    // const Gap(37),
                    // const LoginViaOptions(),
                    const Gap(32),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          Navigator.pushReplacementNamed(
                              context, Routes.mainLayerRoute);
                          await HiveLocaleData.myAppBox?.clear();
                          await LocalePref.prefs?.clear();
                          await HiveLocaleData.myAppBox?.put('notuser', true);
                        },
                        child: Text(
                          LocaleKeys.signinlater.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: AppThemeData.appBlue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
