import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/domain/use_cases/mainmethods.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_cubit.dart';
import 'package:elconnected/presentation/pages/mainlayer_screen.dart';
import 'package:elconnected/presentation/pages/onboardscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    MainAppFunctions.removeSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: AppThemeData.darkThemeData,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        home: HiveLocaleData.myAppBox?.get("inApp") != null &&
                HiveLocaleData.myAppBox?.get("inApp")
            ? MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => HomeDataCubit(),
                  ),
                  BlocProvider(
                    create: (context) => MainLayerNavigationCubit(),
                  ),
                ],
                child: const MainLayerScreen(),
              )
            : const OnBoardScreen(),
      ),
    );
  }
}
