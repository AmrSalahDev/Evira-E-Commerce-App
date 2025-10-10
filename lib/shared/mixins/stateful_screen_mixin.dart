import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

mixin StatefulScreenMixin<T extends StatefulWidget> on State<T> {
  /// Subclasses implement this instead of `build`
  Widget buildBody(BuildContext context);

  bool get showAppBar => true;

  bool get applyPaddingForBottomNavigationBar => true;

  String get title => "";

  Widget? buildBottomNavigationBar() => null;

  void safeSetState(VoidCallback fn) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(fn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: title.isNotEmpty
                  ? Text(
                      title,
                      style: GoogleFonts.urbanist(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textColor,
                      ),
                    )
                  : null,
              leading: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 30.h,

                constraints: BoxConstraints(minWidth: 48.h, minHeight: 48.h),
                color: context.iconColor,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
              ),

              backgroundColor: context.backgroundColor,
              elevation: 0,
              surfaceTintColor: context.backgroundColor,
              toolbarHeight: 80.h,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: buildBody(context),
        ),
      ),
      bottomNavigationBar: applyPaddingForBottomNavigationBar
          ? Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                bottom: MediaQuery.of(
                  context,
                ).viewInsets.bottom, // keyboard height
              ),

              child: buildBottomNavigationBar(),
            )
          : buildBottomNavigationBar(),
    );
  }
}
