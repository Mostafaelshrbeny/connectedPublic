import 'package:flutter/material.dart';

class AppCustomTextField extends StatelessWidget {
  const AppCustomTextField({
    super.key,
    this.onChange,
    this.hint,
    this.suffix,
    this.isHidden = false,
    this.prefix,
    this.initial,
    this.maxlines = 1,
    this.readonly = false,
    this.fillColor,
    this.controller,
    this.validate,
    this.inputType,
    this.action,
  });
  final Function(String)? onChange;
  final TextInputAction? action;
  final String? hint, initial;
  final bool isHidden, readonly;
  final Widget? suffix, prefix;
  final int? maxlines;
  final Color? fillColor;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final TextInputType? inputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: action,
      validator: validate,
      controller: controller,
      initialValue: initial,
      style: Theme.of(context).textTheme.headlineSmall,
      onChanged: onChange,
      readOnly: readonly,
      maxLines: maxlines,
      obscureText: isHidden,
      keyboardType: inputType,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.red),
        filled: true,
        fillColor: fillColor ?? Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
        prefixIcon: prefix,
        suffixIcon: suffix,
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
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: Colors.grey.withOpacity(0.4)),
      ),
    );
  }
}
