import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/widgets/custom_system_ui_overlay_dialog.dart';
import 'package:flutter/material.dart';

class DialogService {
  static Future<T?> showCustomSimpleDialog<T>({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    required String cancelText,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    Widget Function(BuildContext)? builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    TraversalEdgeBehavior? traversalEdgeBehavior,
    bool fullscreenDialog = false,
    bool? requestFocus,
    AnimationStyle? animationStyle,
  }) async {
    return await showDialog(
      context: context,
      barrierColor: Colors.black38,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      traversalEdgeBehavior: traversalEdgeBehavior,
      fullscreenDialog: fullscreenDialog,
      requestFocus: requestFocus,
      animationStyle: animationStyle,
      builder:
          builder ??
          (context) => CustomSystemUiOverlayDialog(
            child: AlertDialog(
              backgroundColor: context.containerColor,
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: onCancel,
                  child: Text(
                    cancelText,
                    style: TextStyle(color: context.textColor),
                  ),
                ),
                TextButton(
                  onPressed: onConfirm,
                  child: Text(
                    confirmText,
                    style: TextStyle(color: context.textColor),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
