import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/domain/use_cases/phone_code.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
    this.readOnly = false,
    this.fillColor,
    this.hint,
    this.validate,
    this.controller,
    this.sufIcon,
    this.withInitial = true,
    this.onChange,
    this.action,
  });
  final bool readOnly, withInitial;
  final Color? fillColor;
  final String? hint;

  final String? Function(String?)? validate;
  final TextEditingController? controller;
  final Widget? sufIcon;
  final Function(PhoneNumber)? onChange;
  final TextInputAction? action;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(LocaleKeys.phoneNumber.tr(),
            style: Theme.of(context).textTheme.headlineSmall),
        const Gap(8),
        IntlPhoneField(
          dropdownDecoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
          textInputAction: action,
          showCountryFlag: false,
          showCursor: !readOnly,
          enabled: !readOnly,
          readOnly: readOnly,
          validator: (p0) {
            if (p0 == null || p0.number.isEmpty) {
              return "required";
            }
            return null;
          },
          pickerDialogStyle: PickerDialogStyle(
              searchFieldInputDecoration: InputDecoration(
                  fillColor: fillColor,
                  hintText: "Search Country",
                  hintStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 0,
                          color: Colors.black.withOpacity(0.5))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 0,
                          color: Colors.black.withOpacity(0.1)))),
              countryCodeStyle: const TextStyle(color: Colors.black)),
          controller: controller,
          dropdownTextStyle: Theme.of(context).textTheme.headlineSmall,
          style: Theme.of(context).textTheme.headlineSmall,
          initialValue: withInitial ? hint : null,
          decoration: InputDecoration(
            suffixIcon: sufIcon,
            prefixIconColor: Colors.black,
            filled: true,
            fillColor: fillColor,
            errorStyle: const TextStyle(color: Colors.red),
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                    style: BorderStyle.solid, width: 0, color: Colors.red)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    width: 0,
                    color: Colors.black.withOpacity(0.1))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                    style: BorderStyle.solid, width: 0, color: Colors.blue)),
          ),
          initialCountryCode: 'EG',
          onChanged: onChange ??
              (phone) {
                PhoneCode.setCode(
                    newCode: phone.countryCode, pNumber: phone.number);
              },
        ),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     CodeDropDown(
        //       disable: readOnly,
        //       fillColor: fillColor,
        //     ),
        //     Expanded(
        //         child: AppCustomTextField(
        //       readonly: readOnly,
        //       hint: hint,
        //       fillColor: fillColor,
        //       validate: validate,
        //     ))
        //   ],
        // ),
      ],
    );
  }
}
