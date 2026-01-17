import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

// ignore: must_be_immutable
class CustomField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  bool isObscure;
  final FormFieldValidator<String>? validator;
  CustomField({
    super.key,
    required this.controller,
    required this.hint,
    this.isObscure = false,
    required this.validator,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isObscure,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: widget.hint == 'Password'
            ? IconButton(
                onPressed: () => setState(() {
                  widget.isObscure = !widget.isObscure;
                }),
                icon: Icon(
                  widget.isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                ),
              )
            : null,
        suffixIconColor: widget.isObscure ? null : AppColors.gradient2,
      ),
    );
  }
}
