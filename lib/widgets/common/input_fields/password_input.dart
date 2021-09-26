import 'package:flutter/material.dart';

/// A [TextField] which can be used for entering passwords
///
/// The entered text is automatically obscured and can be made visible using icon button
/// at the far right of the input field.
class PasswordInput extends StatefulWidget {
  const PasswordInput({
    required this.controller,
    required this.hintText,
    this.errorText,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? errorText;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var _shouldObscurePassword = true;

  @override
  Widget build(BuildContext context) => TextField(
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          hintText: widget.hintText,
          errorText: widget.errorText,
          suffixIcon: IconButton(
            icon: Icon(
              _shouldObscurePassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () => setState(() => _shouldObscurePassword = !_shouldObscurePassword),
          ),
        ),
        obscureText: _shouldObscurePassword,
        autocorrect: false,
      );
}
