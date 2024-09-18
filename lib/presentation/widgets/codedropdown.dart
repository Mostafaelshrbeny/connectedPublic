import 'package:elconnected/constant/device.dart';
import 'package:flutter/material.dart';

class CodeDropDown extends StatelessWidget {
  const CodeDropDown({
    super.key,
    this.fillColor,
    this.disable = false,
  });
  final Color? fillColor;
  final bool disable;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: fillColor ?? Colors.grey.withOpacity(0.3),
          borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(8), bottomStart: Radius.circular(8))),
      width: Device.deviceWidth(context: context, percent: 1 / 5.5),
      child: IgnorePointer(
        ignoring: disable,
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              dropdownColor: fillColor,
              isExpanded: true,
              value: '+21',
              items: const [
                DropdownMenuItem(
                  value: '+21',
                  child: Text('+21'),
                ),
                DropdownMenuItem(
                  value: '+20',
                  child: Text('+20'),
                ),
                DropdownMenuItem(
                  value: '+22',
                  child: Text('+22'),
                ),
              ],
              onChanged: (value) {},
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ),
    );
  }
}
