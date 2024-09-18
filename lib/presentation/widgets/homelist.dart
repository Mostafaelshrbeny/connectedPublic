import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/blocs/MerchantsCubit/merchants_data_cubit.dart';
import 'package:elconnected/presentation/blocs/RecomnededCubit/recommended_foryou_cubit.dart';
import 'package:elconnected/presentation/pages/allmerchants_screen.dart';
import 'package:elconnected/presentation/pages/recommended_screen.dart';
import 'package:elconnected/presentation/widgets/apphorizintalscroll.dart';
import 'package:elconnected/presentation/widgets/homemercahant_list.dart';
import 'package:elconnected/presentation/widgets/recomendedforyou.dart';
import 'package:elconnected/presentation/widgets/top_picks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeList extends StatelessWidget {
  const HomeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          padding: const EdgeInsetsDirectional.only(top: 10, start: 16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: Column(
            children: [
              Center(child: SvgPicture.asset("assets/images/Rectangle 1.svg")),
              Gap(14),
              HomeDataCubit.get(context).allBanners == null ||
                      HomeDataCubit.get(context)
                          .allBanners!
                          .result!
                          .banners!
                          .items!
                          .isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16),
                      child: CachedNetworkImage(
                        imageUrl: HomeDataCubit.get(context)
                                .allBanners
                                ?.result
                                ?.banners
                                ?.items?[0]
                                .imageUrl ??
                            '',
                        placeholder: (context, url) => const SizedBox(),
                        imageBuilder: (context, imageProvider) => Container(
                          margin: EdgeInsets.only(bottom: 24),
                          width: double.infinity,
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? Device.deviceHeight(
                                  context: context, percent: 1 / 7)
                              : Device.deviceHeight(
                                  context: context, percent: 1 / 4),
                          child: Stack(
                            children: [
                              Image(
                                image: imageProvider,
                                width: double.infinity,
                                height: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? Device.deviceHeight(
                                        context: context, percent: 1 / 7)
                                    : Device.deviceHeight(
                                        context: context, percent: 1 / 4),
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  HomeDataCubit.get(context)
                                          .allBanners
                                          ?.result
                                          ?.banners
                                          ?.items?[0]
                                          .endDate
                                          ?.split('T')[0] ??
                                      '',
                                ),
                              )
                            ],
                          ),
                        ),
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
                    ),
              HomeDataCubit.get(context).recommendedItems == null
                  ? const SizedBox()
                  : RowTextLabel(
                      ontap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                    create: (context) =>
                                        RecommendedForyouCubit(),
                                    child: const RecommendedScreen(),
                                  ))),
                      label: LocaleKeys.recommendedforyou.tr(),
                    ),
              HomeDataCubit.get(context).recommendedItems == null
                  ? const SizedBox()
                  : const Gap(12),
              HomeDataCubit.get(context).recommendedItems == null
                  ? const SizedBox()
                  : AppHorizintalScrollList(
                      itemsShow: HomeDataCubit.get(context)
                              .recommendedItems
                              ?.result
                              ?.items
                              ?.items ??
                          []),
              HiveLocaleData.myAppBox!.get('notuser')
                  ? const SizedBox()
                  : const Gap(24),
              HomeDataCubit.get(context).allBanners == null ||
                      HomeDataCubit.get(context)
                              .allBanners!
                              .result!
                              .banners!
                              .items!
                              .length <
                          2
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16),
                      child: CachedNetworkImage(
                        imageUrl: HomeDataCubit.get(context)
                                .allBanners
                                ?.result
                                ?.banners
                                ?.items?[1]
                                .imageUrl ??
                            "",
                        placeholder: (context, url) => const SizedBox(),
                        imageBuilder: (context, imageProvider) => Container(
                          margin: EdgeInsets.only(bottom: 24),
                          width: double.infinity,
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? Device.deviceHeight(
                                  context: context, percent: 1 / 7)
                              : Device.deviceHeight(
                                  context: context, percent: 1 / 4),
                          child: Stack(
                            children: [
                              Image(
                                image: imageProvider,
                                width: double.infinity,
                                height: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? Device.deviceHeight(
                                        context: context, percent: 1 / 7)
                                    : Device.deviceHeight(
                                        context: context, percent: 1 / 4),
                                fit: BoxFit.contain,
                              ),
                              HomeDataCubit.get(context)
                                          .allBanners
                                          ?.result
                                          ?.banners
                                          ?.items![1]
                                          .endDate ==
                                      null
                                  ? const SizedBox()
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 14.w),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                246, 0, 125, 1),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.timer),
                                            Gap(5.w),
                                            CountDownText(
                                              due: DateTime.parse(
                                                  '${HomeDataCubit.get(context).allBanners!.result!.banners!.items![1].endDate!.split('T')[0]} ${HomeDataCubit.get(context).allBanners!.result!.banners!.items![1].endDate!.split('T').last}'),
                                              finishedText: "Done",
                                              showLabel: false,
                                              longDateName: false,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ))
                            ],
                          ),
                        ),
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
                    ),
              const TopPicks(),
              const Gap(24),
              HomeDataCubit.get(context).merchants != null &&
                      HomeDataCubit.get(context)
                          .merchants!
                          .result!
                          .merchants!
                          .items!
                          .isEmpty
                  ? const SizedBox()
                  : RowTextLabel(
                      ontap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                    create: (context) => MerchantsDataCubit(),
                                    child: const AllmerchantsScreen(),
                                  ))),
                      label: LocaleKeys.featuredmerchants.tr(),
                    ),
              const MerchantList(),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }
}
