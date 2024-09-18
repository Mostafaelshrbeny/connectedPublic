import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/models/allcategories_model.dart';
import 'package:elconnected/domain/use_cases/sell_details.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_cubit.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_cubit.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_state.dart';
import 'package:elconnected/presentation/pages/itemtosell_details.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/itemtype_selectionlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SellBottomSheet {
  static sellSheet(
      {required BuildContext context, required AllCategoriesModel categories}) {
    return showModalBottomSheet(
      isDismissible: true,
      enableDrag: false,
      isScrollControlled: true,
      constraints: BoxConstraints(
          maxHeight: Device.deviceHeight(context: context, percent: 1 / 1.4)),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => SellOperationCubit(),
        child: BlocConsumer<SellOperationCubit, SellOperationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.addyourlistings.tr(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Gap(26),
                    Text(
                      LocaleKeys.firstchoosetype.tr(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    ItemTypeSelectionList(
                      catergoies: categories.result!.categories!,
                    ),
                    const Gap(8),
                    SizedBox(
                      height: Device.deviceHeight(
                          context: context, percent: 1 / 15),
                      width: double.infinity,
                      child: Stack(
                        children: [
                          AppCustomButton(
                              buttonChild: Text(
                                LocaleKeys.next.tr(),
                                style: AppThemeData.buttonTextThem(context),
                              ),
                              ontap: () {
                                SellDetails.reset();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                              value: SellOperationCubit.get(
                                                  context)
                                                ..getSellRequirement(
                                                    categories
                                                            .result
                                                            ?.categories?[
                                                                SellOperationCubit
                                                                        .get(
                                                                            context)
                                                                    .selectedItem]
                                                            .id ??
                                                        "0",
                                                    context),
                                              child: ItemToSellDetailsScreen(
                                                id: categories
                                                        .result
                                                        ?.categories?[
                                                            SellOperationCubit
                                                                    .get(
                                                                        context)
                                                                .selectedItem]
                                                        .id ??
                                                    "0",
                                                name: categories
                                                        .result
                                                        ?.categories?[
                                                            SellOperationCubit
                                                                    .get(
                                                                        context)
                                                                .selectedItem]
                                                        .name ??
                                                    "",
                                              ),
                                            )));
                              }),
                          SellOperationCubit.get(context).selectedItem < 0
                              ? Container(
                                  height: Device.deviceHeight(
                                      context: context, percent: 1 / 15),
                                  width: double.infinity,
                                  color: Colors.white.withOpacity(0.8),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ).then((val) {
      MainLayerNavigationCubit.get(context).navigate(0);
    });
  }
}
