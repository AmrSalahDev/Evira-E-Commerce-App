import 'dart:async';

import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/args/no_internet_screen_args.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/cubits/app_flow_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';

class NoInternetScreen extends StatefulWidget {
  final NoInternetScreenArgs? args;
  const NoInternetScreen({super.key, required this.args});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen>
    with StatefulScreenMixin {
  bool _checking = false;

  @override
  String get title => EviraLang.current.noInternetTitle;

  Future<void> _tryAgain() async {
    setState(() => _checking = true);

    final hasAccess = await InternetConnection().hasInternetAccess;

    if (!mounted) return;

    if (hasAccess) {
      if (widget.args == null) {
        await context.read<AppFlowCubit>().checkUserState();
        setState(() => _checking = false);
      } else {
        context.go(widget.args!.targetPath);
        setState(() => _checking = false);
      }
    } else {
      getIt<ToastService>().showErrorToast(
        context: context,
        message: EviraLang.of(context).stillNoInternetConnection,
      );
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.lotties.noInternet.lottie(
              width: 400.w,
              height: 330.h,
              fit: BoxFit.contain,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.colorFilter(
                    const ['**'],
                    value: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              EviraLang.of(context).noInternetConnection,
              style: GoogleFonts.urbanist(
                fontSize: 27.sp,
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15.h),
            Text(
              EviraLang.of(context).noInternetDescription,
              style: TextStyle(fontSize: 18.sp, color: context.textHintColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50.h),
            CustomButton(
              title: EviraLang.of(context).tryAgain,
              onPressed: () async {
                await _tryAgain();
              },
              isLoading: _checking,
              backgroundColor: context.buttonColor,
              textColor: context.buttonTextColor,
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
