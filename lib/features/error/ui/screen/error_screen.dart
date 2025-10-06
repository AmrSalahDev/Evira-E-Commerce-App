import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  final String? error;
  const ErrorScreen({super.key, required this.error});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> with StatefulScreenMixin {
  @override
  String get title => 'Error';

  @override
  Widget buildBody(BuildContext context) {
    return Center(child: Text(widget.error ?? ''));
  }
}
