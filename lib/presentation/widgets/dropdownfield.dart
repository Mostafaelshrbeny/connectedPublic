import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DropDownField extends StatelessWidget {
  const DropDownField({
    super.key,
    required this.label,
    required this.choiceListLabel,
  });
  final String label, choiceListLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.headlineSmall),
        const Gap(4),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12)),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey,
                ),
                isExpanded: true,
                value: choiceListLabel,
                items: [
                  DropdownMenuItem(
                    enabled: false,
                    value: choiceListLabel,
                    child: Text(
                      choiceListLabel,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.grey.withOpacity(0.4)),
                    ),
                  ),
                ],
                onChanged: (value) {},
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        )
      ],
    );
  }
}
