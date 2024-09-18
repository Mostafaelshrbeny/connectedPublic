import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyCodePin extends StatelessWidget {
  const VerifyCodePin({
    super.key,
    this.validate,
    this.controller,
  });
  final String? Function(String?)? validate;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Pinput(
        validator: validate,
        controller: controller,
        length: 4,
        defaultPinTheme: PinTheme(
          width: 50,
          height: 50,
          textStyle: Theme.of(context).textTheme.headlineSmall,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(249, 250, 251, 1),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
