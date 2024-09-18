import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/domain/use_cases/filter_search.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_cubit.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FilterBottomSheetHeadLine extends StatelessWidget {
  const FilterBottomSheetHeadLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCubit, FilterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            FilterCubit.get(context).customSelection
                ? InkWell(
                    onTap: () =>
                        FilterCubit.get(context).switchToCustomSelection(),
                    child: Icon(Icons.arrow_back, color: AppThemeData.appBlue),
                  )
                : const SizedBox(),
            const Gap(8),
            Text(
              FilterCubit.get(context).customSelection
                  ? FilterCubit.get(context).customFilterType
                  : LocaleKeys.filters.tr(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const Spacer(),
            FilterCubit.get(context).customSelection
                ? TextButton(
                    onPressed: () => FilterCubit.get(context).clearAllFilters(),
                    child: Text(
                      LocaleKeys.clearall.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.red),
                    ))
                : Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: AppThemeData.appBlue,
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      FilterSearch.filters.isNotEmpty
                          ? "${LocaleKeys.applyFilters.tr().split(' ')[0]} ${FilterSearch.filters.length} ${LocaleKeys.applyFilters.tr().split(' ')[1]}"
                          : "0",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.white),
                    ),
                  )
          ],
        );
      },
    );
  }
}
