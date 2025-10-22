import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RateBar extends StatelessWidget {
  final Function(int rate) onRateSelected;
  final Function() onAllSelected;
  final int defaultSelectedIndex;

  const RateBar({
    super.key,
    required this.onRateSelected,
    required this.onAllSelected,
    this.defaultSelectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      child: _RateMethodsPart(
        onRateSelected: onRateSelected,
        onAllSelected: onAllSelected,
        defaultSelectedIndex: defaultSelectedIndex,
      ),
    );
  }
}

class _RateMethodsPart extends StatefulWidget {
  final Function(int rate) onRateSelected;
  final Function() onAllSelected;
  final int defaultSelectedIndex;

  const _RateMethodsPart({
    required this.onRateSelected,
    required this.onAllSelected,
    required this.defaultSelectedIndex,
  });

  @override
  State<_RateMethodsPart> createState() => _RateMethodsPartState();
}

class _RateMethodsPartState extends State<_RateMethodsPart> {
  late int selectedIndex;
  List<int> rateList = [5, 4, 3, 2, 1];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.defaultSelectedIndex;
    //  trigger initial selection callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onRateSelected(selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: rateList.length + 1, // +1 for "All"
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          // Handle first item as "All"
          final name = index == 0
              ? EviraLang.of(context).all
              : rateList[index - 1]; // shift index by -1

          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              if (index != 0) {
                widget.onRateSelected(index);
              } else {
                widget.onAllSelected();
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Chip(
                labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                label: Row(
                  children: [
                    Icon(Icons.star, color: context.textColor, size: 20.sp),
                    SizedBox(width: 10.w),
                    Text(
                      name.toString(),
                      style: GoogleFonts.urbanist(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textColor,
                      ),
                    ),
                  ],
                ),

                backgroundColor: isSelected
                    ? context.cardColor
                    : context.backgroundColor,
                side: BorderSide(color: context.cardColor),
                shape: const StadiumBorder(),
              ),
            ),
          );
        },
      ),
    );
  }
}
