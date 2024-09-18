import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/widgets/merchant_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class MerchantList extends StatelessWidget {
  const MerchantList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return HomeDataCubit.get(context).loading
            ? Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 16),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25)),
                      height:
                          Device.deviceHeight(context: context, percent: 1 / 8),
                      width: double.infinity,
                    ),
                    const Gap(10),
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 16),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25)),
                      height:
                          Device.deviceHeight(context: context, percent: 1 / 8),
                      width: double.infinity,
                    ),
                  ],
                ),
              )
            : (HomeDataCubit.get(context).merchants == null ||
                    HomeDataCubit.get(context)
                            .merchants!
                            .result!
                            .merchants!
                            .items ==
                        null ||
                    HomeDataCubit.get(context)
                        .merchants!
                        .result!
                        .merchants!
                        .items!
                        .isEmpty
                ? const SizedBox()
                : ListView.separated(
                    padding: const EdgeInsetsDirectional.only(top: 12, end: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var merchant = HomeDataCubit.get(context)
                          .merchants!
                          .result!
                          .merchants!
                          .items![index];
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
                    itemCount: HomeDataCubit.get(context)
                                .merchants!
                                .result!
                                .merchants!
                                .items!
                                .length >
                            1
                        ? 2
                        : HomeDataCubit.get(context)
                            .merchants!
                            .result!
                            .merchants!
                            .items!
                            .length,
                  ));
      },
    );
  }
}
