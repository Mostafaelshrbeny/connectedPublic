import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class ItemPriceCard extends StatelessWidget {
  const ItemPriceCard({
    super.key,
    required this.price,
  });
  final String price;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.07),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text("$price EGP", style: Theme.of(context).textTheme.headlineLarge),
          const Gap(8),
          // Text("from 24,000 EGP per month",
          //     style: Theme.of(context)
          //         .textTheme
          //         .headlineSmall!
          //         .copyWith(color: Colors.grey.withOpacity(0.8))),
          // const Spacer(),
          // Icon(
          //   Icons.info_outline,
          //   color: Colors.grey.withOpacity(0.3),
          // )
        ],
      ),
    );
  }
}
