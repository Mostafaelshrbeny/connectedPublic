import 'dart:io';

import 'package:elconnected/domain/use_cases/apple_sign.dart';
import 'package:elconnected/domain/use_cases/google_sign_in.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class LoginViaOptions extends StatelessWidget {
  const LoginViaOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppCustomButton(
              backgroundColor: const Color.fromRGBO(1, 101, 225, 1),
              buttonChild: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FaIcon(FontAwesomeIcons.facebookF),
                  const Gap(12),
                  Text(
                    "Facebook",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
              ontap: () async {
                //await AppleAuth.signIn();
              }),
        ),
        const Gap(15),
        Platform.isAndroid
            ? const SizedBox()
            : Expanded(
                child: AppCustomButton(
                    backgroundColor: const Color.fromARGB(255, 102, 107,
                        112), // const Color.fromRGBO(1, 101, 225, 1),
                    buttonChild: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.apple),
                        const Gap(12),
                        Text(
                          "Apple",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                    ontap: () async {
                      await AppleAuth.signIn();
                    }),
              ),
        Platform.isAndroid ? const SizedBox() : const Gap(15),
        Expanded(
          child: AppCustomButton(
              borderColor: Colors.grey.withOpacity(0.2),
              backgroundColor: Colors.white,
              buttonChild: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/Google.png',
                    height: 20,
                    width: 20,
                  ),
                  const Gap(12),
                  Text(
                    "Google",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              ontap: () {
                AuthService.signInWithGoogle();
              }),
        ),
      ],
    );
  }
}
