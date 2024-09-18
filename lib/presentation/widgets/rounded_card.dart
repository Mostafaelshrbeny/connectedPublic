import 'package:flutter/material.dart';

class RoundedCardWithText extends StatelessWidget {
  const RoundedCardWithText(
      {super.key,
      this.cardText,
      this.backgroundColor,
      this.textColor,
      this.borderColor,
      this.ontap,
      this.cardChild,
      this.horPadding = 16,
      this.cardRaduis,
      this.verticalpadding = 8});
  final String? cardText;
  final Color? backgroundColor, textColor, borderColor;
  final Function()? ontap;
  final Widget? cardChild;
  final double? horPadding, cardRaduis, verticalpadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: horPadding!, vertical: verticalpadding!),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor ?? Colors.white),
            borderRadius: BorderRadius.circular(cardRaduis ?? 25)),
        child: cardChild ??
            Text(
              cardText ?? "",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: textColor ?? Colors.white),
            ),
      ),
    );
  }
}
