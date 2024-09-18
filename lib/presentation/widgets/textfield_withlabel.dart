import 'package:elconnected/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TextFieldWithLabel extends StatelessWidget {
  const TextFieldWithLabel({
    super.key,
    required this.label,
    this.hidden = false,
    this.suffix,
    this.hint,
    this.readOnly = false,
    this.fillColor,
    this.controller,
    this.validate,
    this.inputType,
    this.onChange,
    this.removeInit = false,
    this.action,
  });
  final String? label, hint;
  final bool hidden, readOnly, removeInit;
  final Widget? suffix;
  final Color? fillColor;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final TextInputType? inputType;
  final Function(String)? onChange;
  final TextInputAction? action;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap(10),
        AppCustomTextField(
          action: action,
          onChange: onChange,
          inputType: inputType,
          validate: validate,
          readonly: readOnly,
          initial: removeInit ? null : hint,
          controller: controller,
          hint: hint,
          suffix: suffix,
          isHidden: hidden,
          fillColor: fillColor,
        ),
      ],
    );
  }
}
