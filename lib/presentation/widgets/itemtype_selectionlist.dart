import 'package:cached_network_image/cached_network_image.dart';
import 'package:elconnected/data/models/allcategories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_cubit.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_state.dart';

class ItemTypeSelectionList extends StatelessWidget {
  const ItemTypeSelectionList({
    super.key,
    required this.catergoies,
  });
  final List<Categories> catergoies;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellOperationCubit, SellOperationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shrinkWrap: true,
          itemBuilder: (context, index) => InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () =>
                SellOperationCubit.get(context).selectProductType(index),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          SellOperationCubit.get(context).selectedItem == index
                              ? AppThemeData.appBlue
                              : AppThemeData.appBlue.withOpacity(0.01)),
                  color: SellOperationCubit.get(context).selectedItem == index
                      ? AppThemeData.appBlue.withOpacity(0.2)
                      : AppThemeData.appBlue.withOpacity(0.01),
                  borderRadius: BorderRadius.circular(12)),
              height: Device.deviceHeight(
                  context: context,
                  percent:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 1 / 13
                          : 1 / 4),
              width: double.infinity,
              child: Row(
                children: [
                  const Gap(16),
                  CircleAvatar(
                    radius: 11,
                    backgroundColor:
                        SellOperationCubit.get(context).selectedItem == index
                            ? AppThemeData.appBlue
                            : Colors.grey,
                    child: CircleAvatar(
                      radius: 10.5,
                      backgroundColor:
                          SellOperationCubit.get(context).selectedItem == index
                              ? AppThemeData.appBlue
                              : Colors.white,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          catergoies[index].name!,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        // Text(
                        //   AppConstant.catergoryItems[index],
                        //   overflow: TextOverflow.ellipsis,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .headlineSmall!
                        //       .copyWith(color: Colors.grey),
                        // ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                      height: Device.deviceHeight(
                          context: context,
                          percent: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 1 / 13
                              : 1 / 4),
                      width: Device.deviceHeight(
                          context: context,
                          percent: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 1 / 10
                              : 1 / 5),
                      child: CachedNetworkImage(
                        imageUrl: catergoies[index].imageUrl!,
                        imageBuilder: (context, imageProvider) =>
                            Image(image: imageProvider),
                        errorWidget: (context, url, error) => const SizedBox(),
                        placeholder: (context, url) => const SizedBox(),
                      ))
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Gap(12),
          itemCount: catergoies.length,
        );
      },
    );
  }
}
