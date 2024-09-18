import 'package:elconnected/presentation/widgets/rounded_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ItemFeatureCard extends StatelessWidget {
  const ItemFeatureCard({
    super.key,
    required this.featureName,
    required this.featureIcon,
  });
  final String featureName;
  final Widget featureIcon;
  @override
  Widget build(BuildContext context) {
    return RoundedCardWithText(
      cardRaduis: 20,
      horPadding: 8,
      borderColor: Colors.grey.withOpacity(0.5),
      cardChild: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          featureIcon,
          const Gap(4),
          Text(
            featureName,
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}
