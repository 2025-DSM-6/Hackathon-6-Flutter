import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.h,
        color: Colors.black,
      ),
    );

    return TextField(
      obscureText: _isObscured,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: const Color(0xffC9C9C9),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black,
                ),
                onPressed: _toggleVisibility,
              )
            : null,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
