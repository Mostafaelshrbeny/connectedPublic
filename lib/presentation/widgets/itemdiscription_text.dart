import 'package:flutter/material.dart';

class ItemDiscriptionText extends StatelessWidget {
  const ItemDiscriptionText({
    super.key,
    required this.description,
  });
  final String description;
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: description,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.grey)),
      // TextSpan(
      //     text: "Read More",
      //     style: Theme.of(context).textTheme.headlineSmall!,
      //     recognizer: TapGestureRecognizer()..onTap = () {})
    ]));
  }
}
