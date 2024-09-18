import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:flutter/material.dart';

class AppCustomButton extends StatelessWidget {
  const AppCustomButton(
      {super.key,
      required this.buttonChild,
      required this.ontap,
      this.buttonWidth = double.infinity,
      this.buttonPadding,
      this.heightPercent,
      this.backgroundColor,
      this.borderColor,
      this.raduis});
  final Widget buttonChild;
  final Function() ontap;
  final double buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final double? heightPercent, raduis;
  final Color? backgroundColor, borderColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: borderColor ?? backgroundColor ?? AppThemeData.appBlue),
            borderRadius: BorderRadius.circular(raduis ?? 8),
            color: backgroundColor ?? AppThemeData.appBlue),
        margin: buttonPadding,
        width: buttonWidth,
        height: Device.deviceHeight(
            context: context,
            percent: heightPercent ??
                (MediaQuery.of(context).orientation == Orientation.portrait
                    ? 1 / 15
                    : 1 / 8)),
        alignment: Alignment.center,
        child: Center(child: buttonChild),
      ),
    );
  }
}
