import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:flutter/material.dart';

class AdOptionsCard extends StatelessWidget {
  const AdOptionsCard(
      {super.key,
      required this.isChecked,
      required this.adType,
      required this.adDescription,
      required this.price,
      this.ontap,
      required this.suffix});
  final bool isChecked;
  final String adType, adDescription, price;
  final Function()? ontap;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppThemeData.appBlue.withOpacity(0.019),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color:
                    AppThemeData.appBlue.withOpacity(isChecked ? 0.4 : 0.04))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox.adaptive(value: isChecked, onChanged: (value) => ontap),
            SizedBox(
              width: Device.deviceWidth(context: context, percent: 1 / 2.3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adType,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    adDescription,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.grey),
                  ),
                  Text(price,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.green)),
                ],
              ),
            ),
            const Spacer(),
            suffix
          ],
        ),
      ),
    );
  }
}
