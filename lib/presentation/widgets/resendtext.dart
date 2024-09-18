import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/VerifyCubit/verification_cubit.dart';
import 'package:elconnected/presentation/blocs/VerifyCubit/verification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ResendText extends StatelessWidget {
  const ResendText({
    super.key,
    required this.resend,
  });

  final bool resend;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerificationCubit, VerificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Text(LocaleKeys.didntgetthecode.tr(),
                  style: Theme.of(context).textTheme.headlineMedium),
              Gap(10),
              InkWell(
                focusColor: Colors.white.withOpacity(0),
                hoverColor: Colors.white.withOpacity(0),
                splashColor: Colors.white.withOpacity(0),
                highlightColor: Colors.white.withOpacity(0),
                onTap: () {
                  resend ? VerificationCubit.get(context).resendOTP() : null;
                },
                child: Text(LocaleKeys.resend.tr(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: resend
                            ? AppThemeData.appBlue
                            : Colors.grey.withOpacity(0.4))),
              )
            ],
          ),
        );
      },
    );
  }
}
