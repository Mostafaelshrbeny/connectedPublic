import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/domain/use_cases/filter_search.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_cubit.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_state.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_cubit.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBottomSheetContent extends StatefulWidget {
  const FilterBottomSheetContent({
    super.key,
    this.id,
  });
  final String? id;
  @override
  State<FilterBottomSheetContent> createState() =>
      _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<FilterBottomSheetContent> {
  @override
  void initState() {
    widget.id == null
        ? null
        : Future.delayed(Duration.zero).then((val) =>
            FilterCubit.get(context).getSellRequirement(widget.id!, context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCubit, FilterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: FilterCubit.get(context).allfilterswid +
                  [
                    FilterCubit.get(context).allfilterswid.length < 4
                        ? const SizedBox()
                        : AppCustomButton(
                            buttonChild: Text(
                              LocaleKeys.applyFilters.tr(),
                              style: AppThemeData.buttonTextThem(context),
                            ),
                            ontap: () {
                              Navigator.pop(context);
                              SubCatergoriesCubit.get(context).filterSearch(
                                  FilterSearch.filters, widget.id!);
                            })
                  ]),
        );
      },
    );
  }
}
