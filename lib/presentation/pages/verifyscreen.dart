import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/domain/use_cases/phone_code.dart';
import 'package:elconnected/presentation/blocs/VerifyCubit/verification_cubit.dart';
import 'package:elconnected/presentation/blocs/VerifyCubit/verification_state.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/resendtext.dart';
import 'package:elconnected/presentation/widgets/verifycodepin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.seconds});
  final int seconds;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  void initState() {
    VerificationCubit.get(context).startTimer(widget.seconds);
    super.initState();
  }

  TextEditingController codeCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> fKey = GlobalKey();

    return BlocConsumer<VerificationCubit, VerificationState>(
      listener: (context, state) {
        if (state is VerificationDoneState) {
          Navigator.pushNamed(context, Routes.mainLayerRoute);
          HiveLocaleData.myAppBox?.put("inApp", true);
        } else if (state is VerificationFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              VerificationCubit.get(context).errorMsg!,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ));
        } else if (state is ResendFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              VerificationCubit.get(context).errorMsg!,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ));
          VerificationCubit.get(context).resendOption();
        } else if (state is ResendDoneState) {
          VerificationCubit.get(context)
              .startTimer(VerificationCubit.get(context).remain ?? 0);
          VerificationCubit.get(context).resendOption();
        }
      },
      builder: (context, state) {
        int minutes = VerificationCubit.get(context).secondsRemaining ~/ 60;
        int seconds = VerificationCubit.get(context).secondsRemaining % 60;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.verificationCode.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: fKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(30),
                  Text(
                    LocaleKeys.pleaseenterOTP.tr() +
                        (PhoneCode.phone == null
                            ? ''
                            : PhoneCode.phone!
                                    .split('')[PhoneCode.phone!.length - 2] +
                                PhoneCode.phone!
                                    .split('')[PhoneCode.phone!.length - 1]),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.grey),
                  ),
                  Gap(Device.deviceHeight(context: context, percent: 1 / 10)),
                  VerifyCodePin(
                    controller: codeCon,
                    validate: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "Code is required";
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      ResendText(
                        resend: VerificationCubit.get(context).canresend,
                      ),
                      Spacer(),
                      Text(
                        '$minutes:${seconds.toString().padLeft(2, '0')}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ),
                  const Gap(12),
                  VerificationCubit.get(context).loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppThemeData.appBlue,
                          ),
                        )
                      : AppCustomButton(
                          buttonChild: Text(
                            LocaleKeys.verify.tr(),
                            style: AppThemeData.buttonTextThem(context),
                          ),
                          ontap: () {
                            if (fKey.currentState!.validate()) {
                              VerificationCubit.get(context)
                                  .verify(code: codeCon.text);
                            }
                          }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
