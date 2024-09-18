import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ItemMoreInfo extends StatelessWidget {
  const ItemMoreInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Unit Type",
                  style: Theme.of(context).textTheme.headlineMedium),
              const Gap(20),
              Text("Unit Type",
                  style: Theme.of(context).textTheme.headlineMedium),
              const Gap(20),
              Text("Payment Option",
                  style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
          const Gap(40),
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Apratment",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                const Gap(20),
                Text("Apratment",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                const Gap(20),
                Text("Cash & Installments",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
              ])
        ],
      ),
    );
  }
}
