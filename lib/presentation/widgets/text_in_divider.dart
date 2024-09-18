import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:flutter/material.dart';

class TextBetweenDividers extends StatelessWidget {
  const TextBetweenDividers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Text(
            LocaleKeys.orsigninvia.tr(),
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.grey),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
