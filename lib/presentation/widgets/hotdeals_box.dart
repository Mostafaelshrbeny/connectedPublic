import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/appassets.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/models/collection_model.dart';

import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HotDealsBox extends StatelessWidget {
  const HotDealsBox({
    super.key,
    required this.allitems,
  });
  final List<ItemsIn> allitems;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          //  height: Device.deviceHeight(context: context, percent: 1 / 1.3),
          width: double.infinity,
          color: const Color.fromRGBO(252, 239, 232, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    LocaleKeys.hotDeals.tr(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const Gap(4),
                  Image.asset(
                    Assets.hotDealsGif,
                    height: 20,
                    width: 20,
                  )
                ],
              ),
              const Gap(16),
              SizedBox(
                // height: Device.deviceHeight(context: context, percent: 1 / 1.8),
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2 / 2.5,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => AppProductItem(
                    loveWithPadding: true,
                    image: allitems[index].thumbnailUrl!,
                    name: allitems[index].name!,
                    price: allitems[index].price.toString(),
                    id: allitems[index].id!,
                  ),
                  itemCount: allitems.length,
                ),
              ),
              const Gap(20),
              AppCustomButton(
                buttonChild: Text(
                  LocaleKeys.findmoredeals.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: AppThemeData.appBlue),
                ),
                ontap: () {},
                borderColor: AppThemeData.appBlue,
                backgroundColor: Colors.transparent,
              )
            ],
          ),
        );
      },
    );
  }
}
