import 'package:country_picker/country_picker.dart';
import 'package:evira_e_commerce/core/extensions/string_extensions.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class PhoneNumberTextFieldPart extends StatefulWidget {
  final TextEditingController controller;
  final Function(String phoneCode, String countryCode, String phoneNumber)
  onCountrySelected;
  const PhoneNumberTextFieldPart({
    super.key,
    required this.controller,
    required this.onCountrySelected,
  });

  @override
  State<PhoneNumberTextFieldPart> createState() =>
      _PhoneNumberTextFieldPartState();
}

class _PhoneNumberTextFieldPartState extends State<PhoneNumberTextFieldPart> {
  final String _defaultCountryCode = 'EG';
  final String _defaultPhoneCode = '20';
  PhoneCountryData? _initialCountryData;

  @override
  void initState() {
    super.initState();
    _initialCountryData = PhoneCodes.getPhoneCountryDataByCountryCode(
      _defaultCountryCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: _buildInputBorder(context),
      style: GoogleFonts.urbanist(
        color: context.textColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        context.read<TextFieldCubit>().updateField('phone', value);
      },
      maxLength: _initialCountryData?.countryCode == _defaultCountryCode
          ? 11
          : _initialCountryData?.phoneMaskWithoutCountryCode.length,
      // inputFormatters: [
      //   PhoneInputFormatter(
      //     allowEndlessPhone: false,
      //     defaultCountryCode:
      //         _initialCountryData?.countryCode ?? _defaultCountryCode,
      //   ),
      // ],
    );
  }

  InputDecoration _buildInputBorder(BuildContext context) {
    return InputDecoration(
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
      //hintText: _initialCountryData?.phoneMaskWithoutCountryCode,
      hintText: EviraLang.of(context).phoneNumber,
      hintStyle: GoogleFonts.urbanist(
        color: context.textHintColor,
        fontSize: 17.sp,
        fontWeight: FontWeight.w400,
      ),
      counterStyle: GoogleFonts.urbanist(
        color: context.textColor.withAlpha(210),
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),

      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
      prefixIcon: GestureDetector(
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: true,
            onSelect: (Country country) {
              setState(() {
                _initialCountryData =
                    PhoneCodes.getPhoneCountryDataByCountryCode(
                      country.countryCode,
                    );
              });
              widget.onCountrySelected(
                _initialCountryData?.phoneCode ?? _defaultPhoneCode,
                _initialCountryData?.countryCode ?? _defaultCountryCode,
                widget.controller.text,
              );
            },
            countryListTheme: _buildCountryListThemeData(context),
          );
        },
        child: CountryDisplayPart(
          countryCode: _initialCountryData?.countryCode ?? _defaultCountryCode,
          phoneCode: _initialCountryData?.phoneCode ?? _defaultPhoneCode,
        ),
      ),
    );
  }

  CountryListThemeData _buildCountryListThemeData(BuildContext context) {
    return CountryListThemeData(
      bottomSheetHeight: context.screenHeight * 0.8,
      backgroundColor: context.containerColor,
      textStyle: GoogleFonts.urbanist(
        color: context.textColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      searchTextStyle: GoogleFonts.urbanist(
        color: context.textColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      inputDecoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: EviraLang.of(context).search,
        prefixIcon: Icon(Icons.search, color: context.textFieldBorderColor),

        border: OutlineInputBorder(
          borderSide: BorderSide(color: context.textFieldBorderColor),
          borderRadius: BorderRadius.circular(15.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.textFieldBorderColor),
          borderRadius: BorderRadius.circular(15.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        hintStyle: GoogleFonts.urbanist(
          color: context.textHintColor,
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
    );
  }
}

class CountryDisplayPart extends StatelessWidget {
  const CountryDisplayPart({
    super.key,
    required this.countryCode,
    required this.phoneCode,
  });

  final String countryCode;
  final String phoneCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 20.w),
        Text(
          countryCode.countryCodeToEmoji(),
          style: TextStyle(fontSize: 24.sp),
        ),
        SizedBox(width: 5.w),
        Icon(Icons.keyboard_arrow_down, size: 27.sp),
        SizedBox(width: 10.w),
        Text(
          textDirection: TextDirection.ltr,
          '+$phoneCode',
          style: GoogleFonts.urbanist(
            color: context.textColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}
