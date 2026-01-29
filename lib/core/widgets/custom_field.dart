import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// ignore: must_be_immutable
class CustomField extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  bool isObscure;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  CustomField({
    super.key,
    this.controller,
    required this.hint,
    this.isObscure = false,
    this.validator,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
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
