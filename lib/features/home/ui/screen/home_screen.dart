import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/services/social_auth_service.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          title: 'Sign out',
          onPressed: () async {
            await getIt<SocialAuthService>().signOut();
            if (context.mounted) {
              context.go(AppPaths.auth);
            }
          },
          backgroundColor: Colors.red,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
