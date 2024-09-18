import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_cubit.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayerScreen extends StatefulWidget {
  const MainLayerScreen({super.key});

  @override
  State<MainLayerScreen> createState() => _MainLayerScreenState();
}

class _MainLayerScreenState extends State<MainLayerScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero)
        .then((val) => MainLayerNavigationCubit.get(context).appVersionCheck());
    Future.delayed(Duration.zero)
        .then((val) => HomeDataCubit.get(context).getAllHomeData());
    Future.delayed(Duration.zero)
        .then((val) => HomeDataCubit.get(context).getExploreData(context));
    // Future.delayed(Duration.zero)
    //     .then((val) => HomeDataCubit.get(context).getProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness:
            Brightness.dark //or set color with: Color(0xFF0000FF)
        ));
    return BlocConsumer<MainLayerNavigationCubit, MainLayerNavigatonState>(
      listener: (context, state) {},
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            MainLayerNavigationCubit.get(context).currentPage == 0
                ? exit(0)
                : MainLayerNavigationCubit.get(context).navigate(0);
          },
          child: Scaffold(
            body: MainLayerNavigationCubit.get(context)
                .pages[MainLayerNavigationCubit.get(context).currentPage],
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: AppThemeData.appBlue),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              unselectedLabelStyle: Theme.of(context).textTheme.headlineSmall,
              selectedItemColor: AppThemeData.appBlue,
              unselectedItemColor: Colors.black,
              selectedIconTheme: const IconThemeData(size: 24),
              unselectedIconTheme: const IconThemeData(size: 24),
              currentIndex: MainLayerNavigationCubit.get(context).currentPage,
              onTap: (value) =>
                  MainLayerNavigationCubit.get(context).navigate(value),
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.home_filled),
                    label: LocaleKeys.home.tr()),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.search),
                    label: LocaleKeys.search.tr()),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_box,
                      color: AppThemeData.appBlue.withOpacity(0.4),
                    ),
                    label: LocaleKeys.sell.tr()),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.widgets_outlined),
                    label: LocaleKeys.explore.tr()),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: LocaleKeys.account.tr())
              ],
            ),
          ),
        );
      },
    );
  }
}
