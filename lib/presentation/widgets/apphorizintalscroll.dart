import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/collection_model.dart';
import 'package:elconnected/domain/use_cases/sign_in_later_dialog.dart';

import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AppHorizintalScrollList extends StatelessWidget {
  const AppHorizintalScrollList({
    super.key,
    this.itemImage,
    this.scrollBackgroundColor,
    required this.itemsShow,
  });
  final String? itemImage;
  final Color? scrollBackgroundColor;
  final List<ItemsIn> itemsShow;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          color: scrollBackgroundColor ?? Colors.transparent,
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? Device.deviceHeight(context: context, percent: 1 / 4)
              : Device.deviceHeight(context: context, percent: 1 / 2.2),
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsetsDirectional.only(
                        end: index == (itemsShow.length - 1) ? 16 : 0),
                    child: AppProductItem(
                      withColor: false,
                      onlike: () {
                        HiveLocaleData.myAppBox?.get('notuser')
                            ? SignInLaterDialog.signInDialog(context, () {})
                            : (
                                HomeDataCubit.get(context)
                                    .addtoList(int.parse(itemsShow[index].id!)),
                                HomeDataCubit.get(context).likeProduct(
                                    int.parse(itemsShow[index].id!))
                              );
                      },
                      image: itemsShow[index].thumbnailUrl!,
                      name: itemsShow[index].name!,
                      price: itemsShow[index].price.toString(),
                      id: itemsShow[index].id!,
                    ),
                  ),
              separatorBuilder: (context, index) => const Gap(16),
              itemCount: itemsShow.length),
        );
      },
    );
  }
}
