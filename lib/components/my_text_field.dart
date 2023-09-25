import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    this.validator,
    this.hint = "",
    this.obscureText = false,
    this.showToggleIcon = false,
    this.textInputAction,
    this.onSubmitted,
    required this.controller
  });

  final String? Function(String?)? validator;
  final controller;
  final String hint;
  final bool obscureText;
  final bool showToggleIcon;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;

  @override
  State<MyTextField> createState() {
    return _MyTextField();
  }
}

class _MyTextField extends State<MyTextField> {
  bool showToggleIconVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onSubmitted,
      controller: widget.controller,
      validator: widget.validator ,
      obscureText: widget.obscureText && showToggleIconVisible,
      decoration: InputDecoration(
          suffixIcon: suffixIcon(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(36.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(36.0),
            borderSide: const BorderSide(color: Colors.green, width: 3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(36.0),
            borderSide: const BorderSide(color: Colors.red, width: 3),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hint),
    );
  }

  GestureDetector? suffixIcon() {
    if (widget.showToggleIcon) {
      return GestureDetector(
          child: Icon(showToggleIconVisible ? Icons.visibility_off : Icons.visibility),
          onTap: () => {
                setState(() {
                  showToggleIconVisible = !showToggleIconVisible;
                })
              });
    } else {
      return null;
    }
  }
}
