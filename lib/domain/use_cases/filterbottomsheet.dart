import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_cubit.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_state.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_cubit.dart';
import 'package:elconnected/presentation/widgets/filterbottomsheetcontent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBottomSheet {
  static filterSheet(
      BuildContext context, String? id, SubCatergoriesCubit cub) {
    return showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      constraints: BoxConstraints(
          maxHeight: Device.deviceHeight(context: context, percent: 1 / 1.4)),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => FilterCubit(),
        child: BlocConsumer<FilterCubit, FilterState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: BlocProvider.value(
                value: cub,
                child: FilterBottomSheetContent(
                  id: id,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
