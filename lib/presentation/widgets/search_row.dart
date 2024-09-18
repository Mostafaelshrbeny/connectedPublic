import 'package:elconnected/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.onSearch,
    this.con,
  });
  final String hintText;
  final Widget? suffixIcon;
  final Function(String?)? onSearch;
  final TextEditingController? con;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 16),
        child: AppCustomTextField(
            fillColor: const Color.fromRGBO(249, 250, 251, 1),
            controller: con,
            onChange: onSearch,
            hint: hintText,
            prefix: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SvgPicture.asset(
                "assets/images/Group 1000002762.svg",
              ),
            ),
            suffix: suffixIcon),
      ),
    );
  }
}
