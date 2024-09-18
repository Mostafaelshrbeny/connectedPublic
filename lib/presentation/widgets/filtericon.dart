import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/domain/use_cases/filterbottomsheet.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_cubit.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    super.key,
    this.id,
  });
  final String? id;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCatergoriesCubit, SubCatergoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var subCubit = SubCatergoriesCubit.get(context);
        return InkWell(
          onTap: () => FilterBottomSheet.filterSheet(context, id, subCubit),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                color: AppThemeData.appBlue,
                borderRadius: BorderRadius.circular(8)),
            child: SvgPicture.asset("assets/images/Group 1000002761.svg"),
          ),
        );
      },
    );
  }
}
