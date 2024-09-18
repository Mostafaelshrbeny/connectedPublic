import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/presentation/widgets/itemfeature_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class ItemFeaturesRow extends StatelessWidget {
  const ItemFeaturesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ItemFeatureCard(
          featureName: "160 m²",
          featureIcon: Icon(Icons.compare_arrows_outlined,
              size: 20, color: AppThemeData.appBlue),
        ),
        const Gap(8),
        ItemFeatureCard(
          featureName: "3",
          featureIcon:
              Icon(Icons.bed_outlined, size: 20, color: AppThemeData.appBlue),
        ),
        const Gap(8),
        ItemFeatureCard(
          featureName: "2",
          featureIcon: Icon(Icons.bathtub_outlined,
              size: 20, color: AppThemeData.appBlue),
        ),
        const Gap(8),
        ItemFeatureCard(
          featureName: "4th",
          featureIcon: FaIcon(
            FontAwesomeIcons.waterLadder,
            size: 18,
            color: AppThemeData.appBlue,
          ),
        ),
      ],
    );
  }
}
