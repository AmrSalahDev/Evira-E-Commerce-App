import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_recents_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class KeywordItemPart extends StatelessWidget {
  final String keyword;
  final int id;
  final Function(String keyword) onTap;
  const KeywordItemPart({
    super.key,
    required this.keyword,
    required this.id,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(keyword),
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Row(
          children: [
            Text(
              keyword,
              style: GoogleFonts.urbanist(
                fontSize: 22.sp,
                fontWeight: FontWeight.normal,
                color: context.recentColor,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.read<SearchRecentsBloc>().add(
                  DeleteRecentKeywordEvent(id),
                );
              },
              child: Assets.icons.close.svg(
                colorFilter: ColorFilter.mode(
                  context.recentColor,
                  BlendMode.srcIn,
                ),
                height: 30.h,
                width: 30.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
