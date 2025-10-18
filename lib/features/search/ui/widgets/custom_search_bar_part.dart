import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/search/domain/entities/search_recent_keywords_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBarPart extends StatefulWidget {
  final List<SearchRecentKeywordsEntity> keywords;
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final Function(String)? onSearch;

  const CustomSearchBarPart({
    super.key,
    required this.keywords,
    this.onSubmitted,
    required this.controller,
    this.onSearch,
  });

  @override
  State<CustomSearchBarPart> createState() => _CustomSearchBarPartState();
}

class _CustomSearchBarPartState extends State<CustomSearchBarPart> {
  late final TextEditingController suggestionController;
  bool isSearching = false;
  String? suggestion;

  @override
  void initState() {
    super.initState();
    suggestionController = TextEditingController();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final value = widget.controller.text.trim();

    widget.onSearch?.call(value);

    if (value.isEmpty) {
      _updateState(isSearching: false, suggestion: null);
      return;
    }

    final match = AppUtils.suggestionAlgorithm(
      value,
      widget.keywords.map((w) => w.keyword).toList(),
    );

    _updateState(isSearching: true, suggestion: match);
  }

  void _updateState({required bool isSearching, required String? suggestion}) {
    if (!mounted) return;
    setState(() {
      this.isSearching = isSearching;
      this.suggestion = suggestion;
      suggestionController.text = suggestion ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _SuggestionTextField(
          suggestionController: suggestionController,
          isSearching: isSearching,
        ),
        _SearchTextField(
          controller: widget.controller,
          widget: widget,
          isSearching: isSearching,
        ),
      ],
    );
  }
}

class _SearchTextField extends StatelessWidget {
  const _SearchTextField({
    required this.controller,
    required this.widget,
    required this.isSearching,
  });

  final TextEditingController controller;
  final CustomSearchBarPart widget;
  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        widget.onSubmitted?.call(value);
      },

      style: GoogleFonts.sen(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: context.textColor,
      ),

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        filled: true,
        fillColor: Colors.transparent,
        hintStyle: GoogleFonts.sen(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: context.textHintColor,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: context.textFieldBorderColor),
        ),
        prefixIcon: Transform.scale(
          scale: 0.4,
          child: Assets.icons.search.svg(
            height: 24.h,
            width: 24.h,
            colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
          ),
        ),

        suffixIcon: Transform.scale(
          scale: 0.4,
          child: Assets.icons.slidersSimple.svg(
            height: 24.h,
            width: 24.h,
            colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

class _SuggestionTextField extends StatelessWidget {
  final bool isSearching;
  const _SuggestionTextField({
    required this.suggestionController,
    required this.isSearching,
  });

  final TextEditingController suggestionController;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextField(
      animationType: Animationtype.typer,
      controller: suggestionController,
      enabled: false,
      style: GoogleFonts.sen(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade400,
      ),

      hintTexts: isSearching
          ? []
          : [
              'Search for "Electronics"',
              'Search for "Bags"',
              'Search for "Clothes"',
              'Search for "Shoes"',
              'Search for "Watch"',
              'Search for "Jewelry"',
              'Search for "Kitchen"',
              'Search for "Toys"',
            ],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        filled: true,
        fillColor: context.textFieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: context.textFieldBorderColor),
        ),
        prefixIcon: Transform.scale(
          scale: 0.4,
          child: Assets.icons.search.svg(
            height: 24.h,
            width: 24.h,
            colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
          ),
        ),
        suffixIcon: Transform.scale(
          scale: 0.4,
          child: Assets.icons.slidersSimple.svg(
            height: 24.h,
            width: 24.h,
            colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
