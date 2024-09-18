import 'package:easy_localization/easy_localization.dart';

import 'package:elconnected/constant/appconstant.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_cubit.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_state.dart';
import 'package:elconnected/presentation/widgets/additionalfilters.dart';

import 'package:elconnected/presentation/widgets/locationfilter_row.dart';
import 'package:elconnected/presentation/widgets/mainfilteroptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CustomFilterSelection extends StatelessWidget {
  const CustomFilterSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCubit, FilterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            const LocationsFilterRow(),
            const Gap(18),
            Divider(
              color: Colors.grey.withOpacity(0.4),
            ),
            MainFilterOptions(
              options: AppConstant.rowFilterNames,
              label: LocaleKeys.unitType.tr(),
              selectedOption: FilterCubit.get(context).typeFilter,
              isTypeFilter: true,
            ),
            const Gap(18),
            Divider(
              color: Colors.grey.withOpacity(0.4),
            ),
            MainFilterOptions(
              options: AppConstant.areaInM,
              label: LocaleKeys.areain.tr(),
              selectedOption: FilterCubit.get(context).areaFilter,
              isTypeFilter: false,
            ),
            const Gap(18),
            Divider(
              color: Colors.grey.withOpacity(0.4),
            ),
            const Gap(18),
            AdditionalFilterOption(
              ontap: () => FilterCubit.get(context).switchToCustomSelection(),
              label: LocaleKeys.amenities.tr(),
              suffixWithText: true,
            ),
            const Gap(18),
            Divider(
              color: Colors.grey.withOpacity(0.4),
            ),
            const Gap(18),
            AdditionalFilterOption(
              label: LocaleKeys.numberofBedrooms.tr(),
            ),
            const Gap(18),
            Divider(
              color: Colors.grey.withOpacity(0.4),
            ),
            const Gap(18),
            AdditionalFilterOption(
              label: LocaleKeys.numberofBathrooms.tr(),
            ),
            const Gap(18),
            Divider(
              color: Colors.grey.withOpacity(0.4),
            ),
            const Gap(18),
            AdditionalFilterOption(
              label: LocaleKeys.level.tr(),
            ),
          ],
        );
      },
    );
  }
}
