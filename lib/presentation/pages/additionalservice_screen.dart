import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/domain/use_cases/sell_details.dart';
import 'package:elconnected/presentation/blocs/AdditionalServCubit/additional_services_cubit.dart';
import 'package:elconnected/presentation/blocs/AdditionalServCubit/additional_services_state.dart';
import 'package:elconnected/presentation/blocs/VouchersCubit/vouchers_data_cubit.dart';
import 'package:elconnected/presentation/pages/adspayment_screen.dart';
import 'package:elconnected/presentation/widgets/adstypes_selection.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AdditionalServiceScreen extends StatelessWidget {
  const AdditionalServiceScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdditionalServicesCubit, AdditionalServicesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.additionalServices.tr(),
                style: Theme.of(context).textTheme.headlineLarge),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            children: [
              Text(LocaleKeys.youcanboost.tr(),
                  style: Theme.of(context).textTheme.headlineMedium),
              const Gap(12),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                    "assets/images/Screenshot 2024-05-20 at 4.32 1.png",
                    height:
                        Device.deviceHeight(context: context, percent: 1 / 4),
                    width: double.infinity,
                    fit: BoxFit.cover),
              ),
              const Gap(24),
              const AdsTypesSelection(),
              const Gap(32),
              AppCustomButton(
                  buttonChild: Text(LocaleKeys.next.tr(),
                      style: AppThemeData.buttonTextThem(context)),
                  ontap: () {
                    print(SetDetailes.data);
                    // AdditionalServicesCubit.get(context).sellItem();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider(
                                  create: (context) =>
                                      VouchersDataCubit()..getAllVouchers(0),
                                  child: AdsPaymentScreen(id: id),
                                )));
                  })
              // Navigator.pushNamed(context, Routes.adsPaymentRoute))
            ],
          ),
        );
      },
    );
  }
}
