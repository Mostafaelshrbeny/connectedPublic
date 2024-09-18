import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/blocs/MapCubit/map_data_cubit.dart';
import 'package:elconnected/presentation/pages/map_screen.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/profilepicture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            ProfilePicture(
              imageUrl: LocalePref.prefs?.getString("pic") ?? "",
            ),
            const Gap(8),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.hello.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.grey)),
                Text(LocalePref.prefs!.getString("name") ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const Spacer(),
            // AppCustomButton(
            //     heightPercent:
            //         MediaQuery.of(context).orientation == Orientation.portrait
            //             ? 1 / 17
            //             : 1 / 12,
            //     buttonWidth:
            //         Device.deviceWidth(context: context, percent: 1 / 4),
            //     raduis: 30,
            //     buttonChild: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         SvgPicture.asset("assets/images/receipt-discount.svg"),
            //         const Gap(5),
            //         Text(LocaleKeys.offers.tr(),
            //             overflow: TextOverflow.ellipsis,
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .headlineSmall!
            //                 .copyWith(color: Colors.white)),
            //       ],
            //     ),
            //     ontap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (_) => BlocProvider(
            //                     create: (context) => MapDataCubit(),
            //                     child: const MapScreen(),
            //                   )));
            //     }),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.notificationsRoute),
                child: SvgPicture.asset("assets/images/Group 1000002763.svg"),
              ),
            ),
            const Gap(16),
          ],
        );
      },
    );
  }
}
