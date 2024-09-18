import 'dart:io';

import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/appassets.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/AuthenticationCubit/authentication_cubit.dart';
import 'package:elconnected/presentation/blocs/AuthenticationCubit/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, // status bar color
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              AuthenticationCubit.get(context).currentScreen == 0
                  ? exit(0)
                  : AuthenticationCubit.get(context).changeAuthActions(0);
            },
            child: Scaffold(
              backgroundColor: AppThemeData.darkColorScheme.primary,
              body: Padding(
                padding: EdgeInsets.only(
                    top: Device.deviceStatusBar(context: context) + 10),
                child: Stack(
                  children: [
                    Align(
                      alignment: const Alignment(0, -0.9),
                      child: SvgPicture.asset(
                        Assets.appLogoSVG,
                        height: Device.deviceHeight(
                            context: context, percent: 1 / 12),
                        width: Device.deviceWidth(
                            context: context, percent: 1 / 6),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: Device.deviceHeight(
                              context: context, percent: 1 / 5.3),
                          start: 16),
                      // alignment: Alignment(
                      //     0,
                      //     AuthenticationCubit.get(context).currentScreen == 0
                      //         ? -0.56
                      //         : -0.59)
                      //         ,
                      child: SvgPicture.asset(
                          "assets/images/AuthBackGroundShape.svg"),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32))),
                        child: AuthenticationCubit.get(context).authWidgets(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
