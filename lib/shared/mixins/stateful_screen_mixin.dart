import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin StatefulScreenMixin<T extends StatefulWidget> on State<T> {
  /// Subclasses implement body
  Widget buildBody(BuildContext context);

  /// Optional app bar
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: buildBody(context),
        ),
      ),
    );
  }
}
