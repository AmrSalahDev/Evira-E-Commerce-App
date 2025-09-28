import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData? perfixIcon;
  final IconData? suffixIcon;
  final Widget? suffix;
  final bool? obscureText;
  final Function()? onSuffixTap;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final String? fieldKey;
  final Widget? suffixLoading;
  final bool? isSuffixLoading;

  const CustomTextField({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    this.perfixIcon,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.onSuffixTap,
    this.readOnly,
    this.suffix,
    this.inputFormatters,
    this.onTap,
    this.fieldKey,
    this.suffixLoading,
    this.isSuffixLoading,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;
  late VoidCallback _listener;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });

    _listener = () {
      setState(() {});
    };

    widget.controller?.addListener(_listener);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocused = _focusNode.hasFocus;
    final bool hasText = widget.controller?.text.isNotEmpty ?? false;

    final Color iconColor = (isFocused || hasText)
        ? context.iconColor
        : context.hintColor;

    return TextFormField(
      onTap: widget.onTap,
      obscuringCharacter: '●',

      readOnly: widget.readOnly ?? false,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      style: GoogleFonts.urbanist(
        color: context.textColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      focusNode: _focusNode,
      obscureText: widget.obscureText == true && !_obscureText,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: (value) {
        if (widget.readOnly != true && widget.fieldKey != null) {
          context.read<TextFieldCubit>().updateField(widget.fieldKey!, value);
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: context.textFieldColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.textFieldBorderColor),
          borderRadius: BorderRadius.circular(15.r),
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.urbanist(
          color: context.textHintColor,
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        prefixIcon: widget.perfixIcon != null
            ? Icon(widget.perfixIcon, color: iconColor, size: 22.h)
            : null,
        suffixIcon: widget.obscureText != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: iconColor,
                  size: 27.h,
                ),
              )
            : widget.isSuffixLoading == true
            ? widget.suffixLoading
            : widget.suffixIcon != null
            ? GestureDetector(
                onTap: widget.onSuffixTap,
                child: Icon(widget.suffixIcon, color: iconColor, size: 24.h),
              )
            : widget.suffix,
      ),
    );
  }
}
