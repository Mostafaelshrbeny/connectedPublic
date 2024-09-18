import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/widgets/catergorybox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AllCatergoriesPresent extends StatelessWidget {
  const AllCatergoriesPresent({
    super.key,
    this.cardBackground = Colors.white,
  });
  final Color cardBackground;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return HomeDataCubit.get(context).loading
            ? Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 16),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25)),
                  height: Device.deviceHeight(context: context, percent: 1 / 4),
                  width: double.infinity,
                ),
              )
            : HomeDataCubit.get(context).catergories == null ||
                    HomeDataCubit.get(context)
                            .catergories!
                            .result!
                            .categories ==
                        null
                ? const SizedBox()
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                        HomeDataCubit.get(context)
                            .catergories!
                            .result!
                            .categories!
                            .length,
                        (index) => CategoryBox(
                              background: cardBackground,
                              index: index,
                              width: Device.deviceWidth(
                                  context: context,
                                  percent: index <= 1 ? 1 / 2.22 : 1 / 3.4),
                              image: HomeDataCubit.get(context)
                                  .catergories!
                                  .result!
                                  .categories![index]
                                  .imageUrl!,
                              name: HomeDataCubit.get(context)
                                  .catergories!
                                  .result!
                                  .categories![index]
                                  .name!,
                              id: HomeDataCubit.get(context)
                                  .catergories!
                                  .result!
                                  .categories![index]
                                  .id!,
                            ))

                    //[
                    //   CategoryBox(

                    //       background: cardBackground,
                    //       index: 0,
                    //       width:
                    //           Device.deviceWidth(context: context, percent: 1 / 3)),
                    //   CategoryBox(
                    //       background: cardBackground,
                    //       index: 1,
                    //       width: Device.deviceWidth(
                    //           context: context, percent: 1 / 1.89)),
                    //   CategoryBox(
                    //       background: cardBackground,
                    //       index: 2,
                    //       width: Device.deviceWidth(
                    //           context: context, percent: 1 / 3.5)),
                    //   CategoryBox(
                    //       background: cardBackground,
                    //       index: 3,
                    //       width: Device.deviceWidth(
                    //           context: context, percent: 1 / 3.5)),
                    //   CategoryBox(
                    //       background: cardBackground,
                    //       index: 4,
                    //       width: Device.deviceWidth(
                    //           context: context, percent: 1 / 3.5)),
                    // ],
                    );
      },
    );
  }
}
