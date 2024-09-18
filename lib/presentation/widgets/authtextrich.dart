import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/AuthenticationCubit/authentication_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthTextRich extends StatelessWidget {
  const AuthTextRich({
    super.key,
    required this.firstlabel,
    required this.secondlabel,
    required this.secondPage,
  });
  final String firstlabel, secondlabel;
  final int secondPage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Device.deviceWidth(context: context, percent: 3),
      child: Text.rich(
          maxLines: 2,
          TextSpan(children: [
            TextSpan(
                text: firstlabel,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )),
            const TextSpan(text: " "),
            TextSpan(
                text: secondlabel,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppThemeData.appBlue,
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => AuthenticationCubit.get(context)
                      .changeAuthActions(secondPage))
          ])),
    );
  }
}
