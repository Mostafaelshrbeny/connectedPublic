import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/domain/use_cases/phone_code.dart';
import 'package:elconnected/presentation/blocs/AuthenticationCubit/authentication_cubit.dart';
import 'package:elconnected/presentation/blocs/AuthenticationCubit/authentication_state.dart';
import 'package:elconnected/presentation/blocs/SignInCubit/sign_in_cubit.dart';
import 'package:elconnected/presentation/blocs/SignUpCubit/sign_up_cubit.dart';
import 'package:elconnected/presentation/blocs/SignUpCubit/sign_up_state.dart';
import 'package:elconnected/presentation/blocs/VerifyCubit/verification_cubit.dart';
import 'package:elconnected/presentation/pages/verifyscreen.dart';
import 'package:elconnected/presentation/widgets/authtextrich.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/phonetextfield.dart';
import 'package:elconnected/presentation/widgets/textfield_withlabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> fKey = GlobalKey();
    TextEditingController emailCon = TextEditingController();
    TextEditingController passwordCon = TextEditingController();
    TextEditingController firstCon = TextEditingController();
    TextEditingController lastCon = TextEditingController();
    TextEditingController phoneCon = TextEditingController();
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocaleKeys.signup.tr(),
                          style: Theme.of(context).textTheme.displayLarge),
                      const Gap(8),
                      AuthTextRich(
                          firstlabel: LocaleKeys.alreadyhaveAccount.tr(),
                          secondlabel: LocaleKeys.signin.tr(),
                          secondPage: 0),
                      const Gap(32),
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldWithLabel(
                              action: TextInputAction.next,
                              fillColor: const Color.fromRGBO(249, 250, 251, 1),
                              validate: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return 'This Field is required';
                                } else {
                                  return null;
                                }
                              },
                              label: LocaleKeys.firstName.tr(),
                              controller: firstCon,
                              inputType: TextInputType.name,
                            ),
                          ),
                          const Gap(11),
                          Expanded(
                            child: TextFieldWithLabel(
                              action: TextInputAction.next,
                              fillColor: const Color.fromRGBO(249, 250, 251, 1),
                              inputType: TextInputType.name,
                              validate: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return 'This Field is required';
                                } else {
                                  return null;
                                }
                              },
                              label: LocaleKeys.lastName.tr(),
                              controller: lastCon,
                            ),
                          ),
                        ],
                      ),
                      const Gap(24),
                      TextFieldWithLabel(
                        action: TextInputAction.next,
                        fillColor: const Color.fromRGBO(249, 250, 251, 1),
                        inputType: TextInputType.emailAddress,
                        controller: emailCon,
                        label: LocaleKeys.email.tr(),
                        validate: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'This Field is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Gap(24),
                      // Text(
                      //   LocaleKeys.phoneNumber.tr(),
                      //   style: Theme.of(context).textTheme.headlineSmall,
                      // ),
                      // const Gap(10),
                      PhoneTextField(
                        action: TextInputAction.next,
                        fillColor: const Color.fromRGBO(249, 250, 251, 1),
                        controller: phoneCon,
                        validate: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'This Field is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Gap(24),
                      TextFieldWithLabel(
                        action: TextInputAction.next,
                        fillColor: const Color.fromRGBO(249, 250, 251, 1),
                        controller: passwordCon,
                        label: LocaleKeys.password.tr(),
                        validate: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'This Field is required';
                          } else {
                            return null;
                          }
                        },
                        hidden: AuthenticationCubit.get(context).passwordHidden,
                        suffix: IconButton(
                            onPressed: () {
                              AuthenticationCubit.get(context).showPassword();
                            },
                            icon: Icon(
                              AuthenticationCubit.get(context).passwordHidden
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey.withOpacity(0.5),
                            )),
                      ),
                      const Gap(32),
                      BlocProvider(
                        create: (context) => SignUpCubit(),
                        child: BlocConsumer<SignUpCubit, SignUpState>(
                          listener: (context, state) {
                            if (state is SignUpDoneState) {
                              SignUpCubit.get(context).verified
                                  ? {
                                      Navigator.pushNamed(
                                          context, Routes.mainLayerRoute),
                                      HiveLocaleData.myAppBox
                                          ?.put('inApp', true)
                                    }
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider(
                                            create: (context) =>
                                                VerificationCubit(),
                                            child: VerifyScreen(
                                                seconds:
                                                    SignUpCubit.get(context)
                                                            .second ??
                                                        0)),
                                      ));
                            } else if (state is SignUpFailedState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  SignUpCubit.get(context).errorMsg!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 2),
                              ));
                            }
                          },
                          builder: (context, state) {
                            return SignUpCubit.get(context).loading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppThemeData.appBlue,
                                    ),
                                  )
                                : AppCustomButton(
                                    buttonChild: Text(
                                      LocaleKeys.createaccount.tr(),
                                      style:
                                          AppThemeData.buttonTextThem(context),
                                    ),
                                    ontap: () async {
                                      if (fKey.currentState!.validate()) {
                                        SignUpCubit.get(context).userSignup(
                                            email: emailCon.text,
                                            code: PhoneCode.code!,
                                            phone: phoneCon.text,
                                            password: passwordCon.text,
                                            provider: "provider",
                                            providerToken: "providerToken",
                                            firstName: firstCon.text,
                                            lastName: lastCon.text);
                                      }
                                    });
                          },
                        ),
                      ),
                      // const Gap(42),
                      // const TextBetweenDividers(),
                      // const Gap(28),
                      // const LoginViaOptions()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
