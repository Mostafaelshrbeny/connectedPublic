import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/blocs/ProfileCubit/profile_cubit.dart';
import 'package:elconnected/presentation/pages/profile_screen.dart';
import 'package:elconnected/presentation/widgets/profilepicture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.account.tr(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Gap(14),
              Row(
                children: [
                  ProfilePicture(
                      imageUrl: HiveLocaleData.myAppBox!.get('notuser')
                          ? ""
                          : LocalePref.prefs?.getString("pic") ?? ""),
                  const Gap(8),
                  InkWell(
                    onTap: () => HomeDataCubit.get(context).userProfile == null
                        ? null
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                      create: (context) => ProfileCubit(),
                                      child: ProfileScreen(
                                        userProfileData:
                                            HomeDataCubit.get(context)
                                                .userProfile!,
                                      ),
                                    ))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HiveLocaleData.myAppBox!.get('notuser')
                            ? const SizedBox()
                            : Text(
                                "${LocalePref.prefs!.getString("name")} "
                                "${HiveLocaleData.myAppBox?.get("lastname")}",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                        const Gap(4),
                        Row(
                          children: [
                            Text(
                              LocaleKeys.viewandeditprofile.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: AppThemeData.appBlue),
                            ),
                            const Gap(2),
                            Icon(Icons.arrow_forward_ios_rounded,
                                size: 12, color: AppThemeData.appBlue)
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.qrCodeRoute),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 225, 225, 252)),
                      child: Icon(
                        Icons.qr_code,
                        color: AppThemeData.appBlue,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
