import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/appassets.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/widgets/onboard_description.dart';
import 'package:elconnected/presentation/widgets/onboardbottom.dart';
import 'package:flutter/material.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final controller = PageController(keepPage: true);
  double progress = 0.5;
  int current = 0;
  List backGroundColor = [
    const Color.fromRGBO(241, 241, 253, 1),
    const Color.fromRGBO(253, 255, 240, 1),
    const Color.fromRGBO(254, 240, 247, 1)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor[current],
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                progress = 0.5 + (value * 0.25);
                if (current < 2) {
                  current++;
                }
              });
            },
            controller: controller,
            children: [
              OnBoradDescription(
                image: Assets.firstOnBoard,
                label: LocaleKeys.theMarketplace.tr(),
              ),
              OnBoradDescription(
                image: Assets.secondOnBoard,
                label: LocaleKeys.sellyouritems.tr(),
              ),
              OnBoradDescription(
                image: Assets.thirdOnBoard,
                label: LocaleKeys.getthebest.tr(),
              ),
            ],
          ),
          OnBoradBottomRow(
            progress: progress,
            ontap: () {
              if (controller.page == 2) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.authRoute,
                  (route) => false,
                );
              }
              controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear);
            },
          )
        ],
      ),
    );
  }
}
