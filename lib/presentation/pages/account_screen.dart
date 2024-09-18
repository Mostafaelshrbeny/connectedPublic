import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/colors.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/domain/use_cases/sign_in_later_dialog.dart';
import 'package:elconnected/presentation/blocs/AboutAppCubit/about_app_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/blocs/ItemsGridCubit/items_in_grid_cubit.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_cubit.dart';
import 'package:elconnected/presentation/pages/about_term_privacy_screens.dart';
import 'package:elconnected/presentation/pages/appgrid_screens.dart';
import 'package:elconnected/presentation/widgets/account_header.dart';
import 'package:elconnected/presentation/widgets/accountoption_row.dart';
import 'package:elconnected/presentation/widgets/mylisting_card.dart';
import 'package:elconnected/presentation/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    HiveLocaleData.myAppBox!.get('notuser')
        ? Future.delayed(Duration.zero).then((val) =>
            SignInLaterDialog.signInDialog(context,
                () => MainLayerNavigationCubit.get(context).navigate(0)))
        : HomeDataCubit.get(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorHelper.pinkBackGroundColor,
          body: Padding(
            padding: EdgeInsets.only(
                top: Device.deviceStatusBar(context: context) + 10),
            child: ListView(
              padding: EdgeInsets.only(
                top: 0,
              ),
              children: [
                const AccountHeader(),
                const Gap(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(flex: 3, child: MyListingCard()),
                          Gap(8),
                          Expanded(flex: 2, child: WishListCard())
                        ],
                      ),
                      const Gap(40),
                      AccountoptionRow(
                          option: LocaleKeys.sharedItems.tr(),
                          withSuffix: true,
                          prefixIcon: SvgPicture.asset(
                              "assets/images/Group 1000002756.svg"),
                          nextScreenRoute: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (context) => ItemsInGridCubit(),
                                  child: GridListScreens(
                                    arguments: {
                                      "title": LocaleKeys.sharedItems.tr(),
                                      "api": ApiConstant.sharedItems
                                    },
                                  ),
                                ),
                              ))),
                      const Gap(22),
                      AccountoptionRow(
                        option: LocaleKeys.recentlyViewedItems.tr(),
                        withSuffix: true,
                        prefixIcon: SvgPicture.asset(
                            "assets/images/Group 1000002757.svg"),
                        nextScreenRoute: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (context) => ItemsInGridCubit(),
                                child: GridListScreens(
                                  arguments: {
                                    "title":
                                        LocaleKeys.recentlyViewedItems.tr(),
                                    "api": ApiConstant.recentView
                                  },
                                ),
                              ),
                            )),
                      ),
                      const Gap(22),
                      AccountoptionRow(
                          option: LocaleKeys.vouchers.tr(),
                          withSuffix: true,
                          prefixIcon: SvgPicture.asset(
                              "assets/images/Group 1000002758.svg"),
                          nextScreenRoute: () => Navigator.pushNamed(
                              context, Routes.vouchersRoute)),
                      const Gap(22),
                      AccountoptionRow(
                          option: LocaleKeys.settings.tr(),
                          withSuffix: true,
                          prefixIcon: SvgPicture.asset(
                              "assets/images/Group 1000002759.svg"),
                          nextScreenRoute: () {
                            Navigator.pushNamed(context, Routes.settingsRoute);
                          }),
                      const Gap(22),
                      AccountoptionRow(
                          option: LocaleKeys.language.tr(),
                          withSuffix: true,
                          suffixIcon: Text(
                            context.locale == const Locale('en', "US")
                                ? "English"
                                : "العربية",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: AppThemeData.appBlue),
                          ),
                          prefixIcon: SvgPicture.asset(
                              "assets/images/Group 1000002760.svg"),
                          nextScreenRoute: () =>
                              Device.changeLnaguage(context)),
                      // const Gap(22),
                      // AccountoptionRow(
                      //     option: LocaleKeys.helpCentre.tr(),
                      //     withSuffix: true,
                      //     prefixIcon: Icon(
                      //       Icons.headphones,
                      //       color: AppThemeData.appBlue,
                      //     ),
                      //     nextScreenRoute: () {}),
                      const Gap(40),
                      AccountoptionRow(
                          option: LocaleKeys.about.tr(),
                          withSuffix: false,
                          nextScreenRoute: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                          create: (context) => AboutAppCubit(),
                                          child: AboutTermPrivacyScreens(
                                              arguments: {
                                                "title": LocaleKeys.about.tr(),
                                                "Api": ApiConstant.about
                                              }),
                                        )),
                              )),
                      const Gap(22),
                      AccountoptionRow(
                          option: LocaleKeys.termsConditions.tr(),
                          withSuffix: false,
                          nextScreenRoute: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                          create: (context) => AboutAppCubit(),
                                          child: AboutTermPrivacyScreens(
                                              arguments: {
                                                "title": LocaleKeys
                                                    .termsConditions
                                                    .tr(),
                                                "Api":
                                                    ApiConstant.termsNCondition
                                              }),
                                        )),
                              )),
                      const Gap(22),
                      AccountoptionRow(
                          option: LocaleKeys.privacyPolicy.tr(),
                          withSuffix: false,
                          nextScreenRoute: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                          create: (context) => AboutAppCubit(),
                                          child: AboutTermPrivacyScreens(
                                              arguments: {
                                                "title": LocaleKeys
                                                    .privacyPolicy
                                                    .tr(),
                                                "Api":
                                                    ApiConstant.privacyNPolicy
                                              }),
                                        )),
                              )),
                      const Gap(22),
                      // AccountoptionRow(
                      //     option: LocaleKeys.fAQ.tr(),
                      //     withSuffix: false,
                      //     nextScreenRoute: () {}),
                      //const Gap(22),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
