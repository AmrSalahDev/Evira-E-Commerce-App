import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin StatelessScreenMixin on StatelessWidget {
  /// Subclasses implement this instead of `build`
  Widget buildBody(BuildContext context);

  bool get showAppBar => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
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
    );
  }
}
