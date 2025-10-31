import 'package:evira_e_commerce/features/home/ui/cubits/home_app_bar_cubit.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_action_menu_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_greeting_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_user_image_part.dart';
import 'package:evira_e_commerce/features/home/ui/widgets/home_user_name_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class HomeAppBarPart extends StatelessWidget {
  const HomeAppBarPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 25.h),
        BlocBuilder<HomeAppBarCubit, HomeAppBarState>(
          builder: (context, state) {
            return Row(
              children: [
                HomeUserImagePart(imageUrl: state.data?.imageUrl),
                SizedBox(width: 15.w),
                SizedBox(
                  width: context.screenWidth * 0.43,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeGreetingPart(),
                      HomeUserNamePart(name: state.data?.name),
                    ],
                  ),
                ),
                const Spacer(),
                HomeActionMenuPart(),
              ],
            );
          },
        ),
      ],
    );
  }
}
