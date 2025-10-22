import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SortByBar extends StatelessWidget {
  final Function(int sortId) onSortSelected;
  final int defaultSelectedIndex;

  const SortByBar({
    super.key,
    required this.onSortSelected,
    this.defaultSelectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      child: _SortMethodsPart(
        onSortSelected: onSortSelected,
        defaultSelectedIndex: defaultSelectedIndex,
      ),
    );
  }
}

class _SortMethodsPart extends StatefulWidget {
  final Function(int sortId) onSortSelected;

  final int defaultSelectedIndex;

  const _SortMethodsPart({
    required this.onSortSelected,
    required this.defaultSelectedIndex,
  });

  @override
  State<_SortMethodsPart> createState() => _SortMethodsPartState();
}

class _SortMethodsPartState extends State<_SortMethodsPart> {
  late int selectedIndex;
  List<String> sortByList = [
    'Popular',
    'Most Recent',
    'Price High',
    'Price Low',
    'Most Rated',
    'Best Selling',
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.defaultSelectedIndex;
    //  trigger initial selection callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSortSelected(selectedIndex);
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
        itemCount: sortByList.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onSortSelected(index);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Chip(
                label: Text(
                  sortByList[index],
                  style: GoogleFonts.urbanist(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textColor,
                  ),
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
