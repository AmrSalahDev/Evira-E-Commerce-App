import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/cubit/fill_profile_cubit.dart';
import 'package:evira_e_commerce/features/fill_profile/ui/cubit/profile_image_cubit.dart';
import 'package:evira_e_commerce/shared/widgets/image_file_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileImagePart extends StatefulWidget {
  const ProfileImagePart({super.key});

  @override
  State<ProfileImagePart> createState() => _ProfileImagePartState();
}

class _ProfileImagePartState extends State<ProfileImagePart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 180.h,
          height: 180.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.profileBgColor,
          ),
          child: BlocBuilder<ProfileImageCubit, ProfileImageState>(
            builder: (context, state) {
              if (state is ProfileImageLoading) {
                return Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                    color: context.iconColor,
                    size: 30.h,
                  ),
                );
              }
              if (state is ProfileImageLoaded) {
                context.read<FillProfileCubit>().changeImage(state.file);
                return ClipOval(
                  child: ImageFileLoading(
                    file: state.file,
                    width: 180.h,
                    height: 180.h,
                    fit: BoxFit.cover,
                    onError: Assets.icons.profile.svg(
                      width: 150.w,
                      height: 150.h,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        context.profileIconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                );
              }
              if (state is ProfileImageError) {
                return Assets.icons.profile.svg(
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    context.profileIconColor,
                    BlendMode.srcIn,
                  ),
                );
              }
              return Assets.icons.profile.svg(
                width: 150.w,
                height: 150.h,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  context.profileIconColor,
                  BlendMode.srcIn,
                ),
              );
            },
          ),
        ),
        Positioned(
          right: 10.w,
          bottom: 5.h,
          child: GestureDetector(
            onTap: () async =>
                await context.read<ProfileImageCubit>().pickImage(),
            child: Container(
              width: 37.h,
              height: 37.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.iconColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                FontAwesomeIcons.pen,
                color: context.textActiveColor,
                size: 22.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
