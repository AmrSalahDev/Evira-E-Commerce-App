import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

abstract class BaseStatelessScreen extends StatelessWidget {
  final bool expandBody;
  const BaseStatelessScreen({super.key, this.expandBody = false});

  /// Static default padding to avoid creating new instances on every build
  static EdgeInsetsGeometry get _defaultPadding =>
      EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h);

  /// Override if needed (return null to hide header)
  Widget? buildHeader(BuildContext context) => _DefaultBackButton();

  /// Body is required
  Widget buildBody(BuildContext context);

  /// Override if needed (return null to hide footer)
  Widget? buildFooter(BuildContext context) =>
      throw UnimplementedError('buildBody must be implemented by subclasses');

  Widget buildScaffold(BuildContext context, Widget body) {
    final footer = buildFooter(context);

    return Scaffold(
      body: SafeArea(child: body),
      bottomNavigationBar: footer != null ? buildFooter(context)! : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build widgets once to avoid multiple calls
    final header = buildHeader(context);
    final body = buildBody(context);

    final content = Padding(
      padding: _defaultPadding,
      child: Column(
        children: [
          /// Header (if provided)
          if (header != null) buildHeader(context)!,

          /// Body (always required)
          if (expandBody) Expanded(child: body) else body,
        ],
      ),
    );

    return buildScaffold(context, content);
  }
}

class _DefaultBackButton extends StatelessWidget {
  const _DefaultBackButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        iconSize: 30.h,
        color: context.iconColor,
        onPressed: () => context.pop(),
        // Add padding and constraints for better touch target
        constraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
        padding: EdgeInsets.zero,
      ),
    );
  }
}


// Example usage:

/// Example stateless screen implementation
// class ExampleStatelessScreen extends BaseStatelessScreen {
//   const ExampleStatelessScreen({super.key});
  
//   @override
//   Widget buildBody(BuildContext context) {
//     return const Center(
//       child: Text('This is a stateless screen'),
//     );
//   }
  
//   @override
//   Widget? buildFooter(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 16.h),
//       child: ElevatedButton(
//         onPressed: () {},
//         child: const Text('Action Button'),
//       ),
//     );
//   }
// }



/// Advanced example with custom scaffold
// class CustomScaffoldScreen extends BaseStatelessScreen {
//   const CustomScaffoldScreen({super.key});
  
//   @override
//   Widget buildScaffold(BuildContext context, Widget body) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text('Custom Scaffold'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: body,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
  
//   @override
//   Widget? buildHeader(BuildContext context) {
//     // No header since we're using AppBar
//     return null;
//   }
  
//   @override
//   Widget buildBody(BuildContext context) {
//     return const Center(
//       child: Text('Custom scaffold with AppBar and FAB'),
//     );
//   }
// }