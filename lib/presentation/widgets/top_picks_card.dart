import 'package:elconnected/constant/device.dart';
import 'package:flutter/material.dart';

class TopPicksCard extends StatelessWidget {
  const TopPicksCard({super.key, required this.cardChild});
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Device.deviceWidth(context: context, percent: 1 / 4.7),
      height: Device.deviceWidth(context: context, percent: 1 / 4.5),
      decoration: BoxDecoration(
          color: const Color.fromARGB(153, 239, 245, 255),
          borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: cardChild,
      ),
    );
  }
}
