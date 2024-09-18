import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/MerchantsCubit/merchants_data_cubit.dart';
import 'package:elconnected/presentation/blocs/MerchantsCubit/merchants_data_state.dart';

import 'package:elconnected/presentation/widgets/merchant_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AllmerchantsScreen extends StatefulWidget {
  const AllmerchantsScreen({super.key});

  @override
  State<AllmerchantsScreen> createState() => _AllmerchantsScreenState();
}

class _AllmerchantsScreenState extends State<AllmerchantsScreen> {
  @override
  void initState() {
    scControll.addListener(scrollListener);
    Future.delayed(Duration.zero)
        .then((val) => MerchantsDataCubit.get(context).getMerchants(0));
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controller to avoid memory leaks
    scControll.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scControll.offset >= scControll.position.maxScrollExtent - 200 &&
        !scControll.position.outOfRange) {
      MerchantsDataCubit.get(context).scroll();
    }
  }

  ScrollController scControll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MerchantsDataCubit, MerchantsDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.featuredmerchants.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            centerTitle: true,
          ),
          body: MerchantsDataCubit.get(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppThemeData.appBlue,
                  ),
                )
              : MerchantsDataCubit.get(context).merchantsList.isEmpty
                  ? Center(
                      child: Text(
                        LocaleKeys.noItems.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: AppThemeData.appBlue),
                      ),
                    )
                  : ListView.separated(
                      controller: scControll,
                      padding: const EdgeInsetsDirectional.only(
                          top: 12, end: 16, start: 16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var merchant = MerchantsDataCubit.get(context)
                            .merchantsList[index];
                        return MerchantRow(
                            image: merchant.logoUrl ?? '',
                            name: merchant.name ?? '',
                            catergory: merchant.shortDescription ?? '',
                            categoryImage: merchant.mainItemUrl ?? '',
                            rating: merchant.rating ?? "0",
                            ratingNumber: merchant.ratingsCount ?? "0");
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Gap(16),
                      itemCount:
                          MerchantsDataCubit.get(context).merchantsList.length),
        );
      },
    );
  }
}
