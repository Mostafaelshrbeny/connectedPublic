import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/blocs/SectionDataCubit/sections_data_cubit.dart';
import 'package:elconnected/presentation/pages/sctions_screen.dart';
import 'package:elconnected/presentation/widgets/top_picks_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class TopPicks extends StatelessWidget {
  const TopPicks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.toppicks.tr(),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(12),
            SizedBox(
              height: Device.deviceHeight(context: context, percent: 1 / 10),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => CachedNetworkImage(
                        imageUrl: HomeDataCubit.get(context)
                                .homeCollection
                                ?.result
                                ?.collections
                                ?.items?[index]
                                .bannerUrl ??
                            '',
                        imageBuilder: (context, imageProvider) => InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) =>
                                            SectionsDataCubit(),
                                        child: SctionsScreen(
                                          id: HomeDataCubit.get(context)
                                                  .homeCollection
                                                  ?.result
                                                  ?.collections
                                                  ?.items?[index]
                                                  .id ??
                                              0,
                                          name: HomeDataCubit.get(context)
                                                  .homeCollection
                                                  ?.result
                                                  ?.collections
                                                  ?.items?[index]
                                                  .name ??
                                              '',
                                        ),
                                      ))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: imageProvider,
                              height: Device.deviceHeight(
                                  context: context, percent: 1 / 10),
                              width: Device.deviceHeight(
                                  context: context, percent: 1 / 10),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const SizedBox(),
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
                  separatorBuilder: (context, index) => const Gap(5),
                  itemCount: HomeDataCubit.get(context)
                          .homeCollection
                          ?.result
                          ?.collections
                          ?.items
                          ?.length ??
                      0),
            )
          ],
        );
      },
    );
  }
}

class NewArrivalCard extends StatelessWidget {
  const NewArrivalCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TopPicksCard(
        cardChild: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(LocaleKeys.nEW.tr(),
            style: GoogleFonts.markoOne(
                fontSize: 24,
                color: AppThemeData.appBlue,
                fontWeight: FontWeight.w500)),
        Text(
          LocaleKeys.arrivals.tr(),
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppThemeData.appBlue),
        )
      ],
    ));
  }
}
