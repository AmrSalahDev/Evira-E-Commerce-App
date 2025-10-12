import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/features/notification/domain/service/notification_service.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/notification/data/models/notification_model.dart';
import 'package:evira_e_commerce/features/notification/ui/screens/notificaton_screen.dart';
import 'package:evira_e_commerce/features/set_fingerprint/ui/cubit/fingerprint_cubit.dart';
import 'package:evira_e_commerce/features/set_fingerprint/ui/dialogs/account_setup_successful_dialog.dart';
import 'package:evira_e_commerce/features/set_fingerprint/ui/dialogs/go_settings_dialog.dart';
import 'package:evira_e_commerce/shared/cubits/app_flow_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SetFingerprintScreen extends StatefulWidget {
  const SetFingerprintScreen({super.key});

  @override
  State<SetFingerprintScreen> createState() => _SetFingerprintScreenState();
}

class _SetFingerprintScreenState extends State<SetFingerprintScreen>
    with StatefulScreenMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  String get title => EviraLang.current.setYourFingerprint;

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            SizedBox(height: 30.h),

            Text(
              EviraLang.of(context).addFingerprint,
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                color: context.textColor,
              ),
            ),

            SizedBox(height: 60.h),

            Assets.lotties.fingerprint.lottie(
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

            SizedBox(height: 60.h),

            Text(
              EviraLang.of(context).putYourFinger,
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                color: context.textColor,
              ),
            ),

            SizedBox(height: 70.h),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: EviraLang.of(context).skip,
                    onPressed: () async {
                      await AccountSetupSuccessfulDialog.show(
                        context,
                        onDone: () async {
                          await context
                              .read<FingerprintCubit>()
                              .saveFingerprint();
                          if (context.mounted) {
                            await context.read<AppFlowCubit>().checkUserState();
                          }
                        },
                      );
                    },
                    backgroundColor: context.grayBackgroundColor,
                    textColor: context.textColor,
                  ),
                ),
                SizedBox(width: 16.w),

                Expanded(
                  child: BlocConsumer<FingerprintCubit, FingerprintState>(
                    listener: (context, state) {
                      if (state is FingerprintNotEnrolled) {
                        GoSettingsDialog.show(context);
                      } else if (state is FingerprintLockedOut) {
                        getIt<ToastService>().showWarningToast(
                          context: context,
                          message: EviraLang.of(context).tooManyAttempts,
                        );
                      } else if (state is FingerprintError) {
                        getIt<ToastService>().showErrorToast(
                          context: context,
                          message: state.message,
                        );
                      } else if (state is FingerprintSuccess) {
                        AccountSetupSuccessfulDialog.show(
                          context,
                          onDone: () async {
                            await context
                                .read<FingerprintCubit>()
                                .saveFingerprint();
                            if (context.mounted) {
                              context.read<AppFlowCubit>().checkUserState();
                            }
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      bool isLoading = state is FingerprintLoading;
                      return CustomButton(
                        isLoading: isLoading,
                        loadingWidget: Assets.lotties.fingerprint.lottie(
                          width: 50.h,
                          height: 50.h,
                          fit: BoxFit.contain,
                          delegates: LottieDelegates(
                            values: [
                              ValueDelegate.colorFilter(
                                const ['**'],
                                value: ColorFilter.mode(
                                  context.buttonTextColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: EviraLang.of(context).continuee,
                        onPressed: () async {
                          await context.read<FingerprintCubit>().authenticate();
                        },
                        backgroundColor: context.buttonColor,
                        textColor: context.buttonTextColor,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
