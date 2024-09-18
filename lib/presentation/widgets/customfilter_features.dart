import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/appconstant.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/domain/use_cases/filter_search.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_cubit.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_state.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CustomFilterFeatures extends StatelessWidget {
  const CustomFilterFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCubit, FilterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () => FilterCubit.get(context)
                    .addCustomFilter(AppConstant.features[index]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Text(AppConstant.features[index],
                          style: Theme.of(context).textTheme.headlineMedium),
                      const Spacer(),
                      FilterSearch.filters.contains(AppConstant.features[index])
                          ? Icon(Icons.check_box_sharp,
                              color: AppThemeData.appBlue)
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.grey,
                thickness: 0.4,
              ),
              itemCount: AppConstant.features.length,
            ),
            const Gap(30),
            AppCustomButton(
                buttonChild: Text(LocaleKeys.confirm.tr()),
                ontap: () => FilterCubit.get(context).switchToCustomSelection())
          ],
        );
      },
    );
  }
}
