import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// Base class for stateful screens with consistent layout structure
abstract class BaseStatefulScreen extends StatefulWidget {
  final bool expandBody;

  const BaseStatefulScreen({super.key, this.expandBody = false});

  @override
  BaseStatefulScreenState createState() =>
      BaseStatefulScreenState<BaseStatefulScreen>();
}

/// State class for BaseStatefulScreen
class BaseStatefulScreenState<T extends BaseStatefulScreen> extends State<T> {
  /// Static default padding to avoid creating new instances on every build
  static EdgeInsetsGeometry get _defaultPadding =>
      EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h);

  /// Override to customize header (return null to hide)
  Widget? buildHeader(BuildContext context) => _DefaultBackButton();

  /// Body is required - main content goes here
  Widget buildBody(BuildContext context) {
    throw UnimplementedError('buildBody must be implemented by subclasses');
  }

  /// Override to add footer (return null to hide)
  Widget? buildFooter(BuildContext context) => null;

  /// Override to customize the scaffold
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          if (header != null) header,

          // Body (expanded or not based on expandBody flag)
          if (widget.expandBody) Expanded(child: body) else body,
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



/// Example stateful screen implementation
// class ExampleStatefulScreen extends BaseStatefulScreen {
//   const ExampleStatefulScreen({super.key});
  
//   @override
//   BaseStatefulScreenState createState() => _ExampleStatefulScreenState();
// }

// class _ExampleStatefulScreenState extends BaseStatefulScreenState {
//   int _counter = 0;
  
//   @override
//   Widget buildBody(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Counter: $_counter'),
//           SizedBox(height: 16.h),
//           ElevatedButton(
//             onPressed: () => setState(() => _counter++),
//             child: const Text('Increment'),
//           ),
//         ],
//       ),
//     );
//   }
  
//   @override
//   Widget? buildHeader(BuildContext context) {
//     return Row(
//       children: [
//         // Use default back button
//         Expanded(child: super.buildHeader(context) ?? const SizedBox()),
//         // Add custom header content
//         Text(
//           'Counter App',
//           style: Theme.of(context).textTheme.headlineSmall,
//         ),
//         SizedBox(width: 48.w), // Balance the back button
//       ],
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