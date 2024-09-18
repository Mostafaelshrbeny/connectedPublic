import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_cubit.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AdditionalFilterOption extends StatelessWidget {
  const AdditionalFilterOption({
    super.key,
    required this.label,
    this.suffixWithText = false,
    this.ontap,
  });
  final String label;
  final bool suffixWithText;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCubit, FilterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  LocaleKeys.any.tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: ontap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  suffixWithText
                      ? Text(
                          LocaleKeys.select.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: AppThemeData.appBlue),
                        )
                      : const SizedBox(),
                  const Gap(4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: AppThemeData.appBlue,
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
