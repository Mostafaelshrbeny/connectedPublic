import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_cubit.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_state.dart';
import 'package:elconnected/presentation/widgets/rounded_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MainFilterOptions extends StatelessWidget {
  const MainFilterOptions({
    super.key,
    required this.options,
    required this.label,
    required this.selectedOption,
    required this.isTypeFilter,
  });
  final List<String> options;
  final String label, selectedOption;
  final bool isTypeFilter;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCubit, FilterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(12),
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
            const Gap(8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                  options.length,
                  (index) => RoundedCardWithText(
                      ontap: () {
                        isTypeFilter
                            ? FilterCubit.get(context)
                                .selectType(options[index])
                            : FilterCubit.get(context)
                                .selectArea(options[index]);
                      },
                      backgroundColor: selectedOption == options[index]
                          ? AppThemeData.appBlue
                          : null,
                      borderColor: selectedOption == options[index]
                          ? null
                          : Colors.grey.withOpacity(0.4),
                      textColor: selectedOption == options[index]
                          ? Colors.white
                          : Colors.grey,
                      cardText: options[index])),
            ),
          ],
        );
      },
    );
  }
}
