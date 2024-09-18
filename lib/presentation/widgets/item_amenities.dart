import 'package:elconnected/presentation/widgets/rounded_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ItemAmenitiesRow extends StatelessWidget {
  const ItemAmenitiesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedCardWithText(
          cardText: "Balcony",
          borderColor: Colors.grey.withOpacity(0.8),
          textColor: Colors.grey.withOpacity(0.8),
        ),
        const Gap(8),
        RoundedCardWithText(
          cardText: "Private Garen",
          borderColor: Colors.grey.withOpacity(0.8),
          textColor: Colors.grey.withOpacity(0.8),
        ),
        const Gap(8),
        RoundedCardWithText(
          cardText: "Security",
          borderColor: Colors.grey.withOpacity(0.8),
          textColor: Colors.grey.withOpacity(0.8),
        ),
        const Gap(8),
      ],
    );
  }
}
