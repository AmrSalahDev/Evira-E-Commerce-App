import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Widget child;
  const CustomBottomNavigationBar({super.key, required this.child});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: SizedBox(
        height: 80.h,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: context.backgroundColor,
          useLegacyColorScheme: false,
          selectedLabelStyle: GoogleFonts.sen(
            height: 2,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: context.iconColor,
          ),
          unselectedLabelStyle: GoogleFonts.sen(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: context.hintColor,
          ),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
            switch (index) {
              case 0:
                context.pushReplacement(AppPaths.home);
                break;
              case 1:
                //context.pushReplacement(AppPaths.cart);
                break;
              case 2:
                //context.pushReplacement(AppPaths.orders);
                break;
              case 3:
                //context.pushReplacement(AppPaths.wallet);
                break;
              case 4:
                context.pushReplacement(AppPaths.profile);
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              backgroundColor: context.backgroundColor,
              label: EviraLang.of(context).home,
              icon: Assets.icons.home.image(
                color: context.iconColor,
                height: 27.h,
                width: 27.h,
              ),
              activeIcon: Assets.icons.homeActive.image(
                color: context.iconColor,
                height: 27.h,
                width: 27.h,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: context.backgroundColor,
              label: EviraLang.of(context).cart,
              icon: Assets.icons.cart.image(
                color: context.hintColor,
                height: 27.h,
                width: 27.h,
              ),
              activeIcon: Assets.icons.cartActive.image(
                color: context.iconColor,
                height: 27.h,
                width: 27.h,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: context.backgroundColor,
              activeIcon: Assets.icons.ordersActive.image(
                color: context.iconColor,
                height: 27.h,
                width: 27.h,
              ),
              icon: Assets.icons.orders.image(
                height: 27.h,
                width: 27.h,
                color: context.hintColor,
              ),
              label: EviraLang.of(context).orders,
            ),
            BottomNavigationBarItem(
              backgroundColor: context.backgroundColor,
              label: EviraLang.of(context).wallet,
              icon: Assets.icons.wallet.image(
                color: context.hintColor,
                height: 27.h,
                width: 27.h,
              ),
              activeIcon: Assets.icons.walletActive.image(
                color: context.iconColor,
                height: 27.h,
                width: 27.h,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: context.backgroundColor,
              label: EviraLang.of(context).profile,
              icon: Assets.icons.person.image(
                color: context.hintColor,
                height: 27.h,
                width: 27.h,
              ),
              activeIcon: Assets.icons.personActive.image(
                color: context.iconColor,
                height: 27.h,
                width: 27.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
