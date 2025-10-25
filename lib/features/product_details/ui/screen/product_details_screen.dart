import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/args/product_details_screen_args.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/product_details/domain/entities/product_details_entity.dart';
import 'package:evira_e_commerce/features/product_details/ui/bloc/product_details_bloc.dart';
import 'package:evira_e_commerce/features/wishlist/domain/services/wishlist_service.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsScreenArgs? args;
  const ProductDetailsScreen({super.key, required this.args});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsBloc>().add(
      GetProductDetailsEvent(productId: widget.args!.productId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SystemUIWrapper(
      statusBarColor: context.cardColor,
      statusBarIconBrightness: context.isDark
          ? Brightness.light
          : Brightness.light,
      navigationBarColor: context.backgroundColor,
      navigationBarIconBrightness: context.isDark
          ? Brightness.light
          : Brightness.light,
      child: Scaffold(
        body:
            BlocSelector<
              ProductDetailsBloc,
              ProductDetailsState,
              ProductDetailsEntity?
            >(
              selector: (state) =>
                  state is ProductDetailsLoaded ? state.productDetails : null,
              builder: (context, productDetails) {
                if (productDetails != null) {
                  return SingleChildScrollView(
                    clipBehavior: Clip.none,
                    child: Column(
                      children: [
                        HeaderPart(productDetais: productDetails),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProductInfoPart(productDetais: productDetails),
                              SizedBox(height: 10.h),
                              Divider(color: context.dividerColor),
                              SizedBox(height: 10.h),
                              Text(
                                EviraLang.of(context).description,
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp,
                                  color: context.textColor,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              DescriptionPart(productDetails: productDetails),
                              SizedBox(height: 10.h),
                              CustomizePart(productDetails: productDetails),
                              SizedBox(height: 15.h),
                              QuantityPart(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
        bottomNavigationBar:
            BlocSelector<
              ProductDetailsBloc,
              ProductDetailsState,
              ProductDetailsEntity?
            >(
              selector: (state) =>
                  state is ProductDetailsLoaded ? state.productDetails : null,
              builder: (context, productDetails) {
                if (productDetails != null) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    color: context.backgroundColor,
                    margin: EdgeInsets.only(bottom: 10.h),
                    alignment: Alignment.center,
                    height: 80.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              EviraLang.of(context).totalPrice,
                              style: GoogleFonts.urbanist(
                                fontSize: 16.sp,
                                color: context.textSmallGrayColor,
                              ),
                            ),
                            Text(
                              "\$${productDetails.price}",
                              style: GoogleFonts.urbanist(
                                fontSize: 25.sp,
                                color: context.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20.w),
                        Flexible(
                          child: CustomButton(
                            handleNoInternet: true,
                            icon: Icon(
                              Icons.shopping_bag,
                              color: context.buttonTextColor,
                              size: 30.h,
                            ),
                            title: EviraLang.of(context).addToCart,
                            onPressed: () {},
                            backgroundColor: context.buttonColor,
                            textColor: context.buttonTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
      ),
    );
  }
}

class QuantityPart extends StatelessWidget {
  const QuantityPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          EviraLang.of(context).quantity,
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: context.textColor,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Icon(Icons.remove, color: context.textColor),
              ),
              SizedBox(width: 15.w),
              Text(
                "1",
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: context.textColor,
                ),
              ),
              SizedBox(width: 15.w),
              InkWell(
                onTap: () {},
                child: Icon(Icons.add, color: context.textColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomizePart extends StatelessWidget {
  final ProductDetailsEntity productDetails;
  const CustomizePart({super.key, required this.productDetails});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          if (productDetails.sizes.isNotEmpty) ...[
            SizePart(productDetails: productDetails),
            SizedBox(width: 20.w),
          ],

          if (productDetails.colors.isNotEmpty) ...[
            ColorPart(productDetails: productDetails),
          ],
        ],
      ),
    );
  }
}

class DescriptionPart extends StatelessWidget {
  const DescriptionPart({super.key, required this.productDetails});

  final ProductDetailsEntity productDetails;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      '${productDetails.description} ',
      trimMode: TrimMode.Line,
      trimLines: 2,

      trimCollapsedText: EviraLang.of(context).showMore,
      trimExpandedText: EviraLang.of(context).showLess,
      style: GoogleFonts.urbanist(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: context.textSmallGrayColor,
      ),
      moreStyle: GoogleFonts.urbanist(
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        color: context.textColor,
      ),
      lessStyle: GoogleFonts.urbanist(
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        color: context.textColor,
      ),
    );
  }
}

class SizePart extends StatefulWidget {
  final ProductDetailsEntity productDetails;
  const SizePart({super.key, required this.productDetails});

  @override
  State<SizePart> createState() => _SizePartState();
}

class _SizePartState extends State<SizePart> {
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    if (widget.productDetails.sizes.isNotEmpty &&
        widget.productDetails.sizes.length > 1) {
      selectedSize = widget.productDetails.sizes[1].sizeLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        Text(
          EviraLang.of(context).size,
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: context.textColor,
          ),
        ),
        SizedBox(height: 10.h),
        Wrap(
          children: widget.productDetails.sizes.map((s) {
            return ChoiceChip(
              label: Text(s.sizeLabel),
              showCheckmark: false,
              padding: EdgeInsets.all(12.h),
              backgroundColor: context.backgroundColor,
              selectedColor: context.buttonColor,
              labelStyle: GoogleFonts.urbanist(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: selectedSize == s.sizeLabel
                    ? context.buttonTextColor
                    : context.textSmallGrayColor,
              ),
              selected: selectedSize == s.sizeLabel,
              shape: CircleBorder(
                side: BorderSide(color: context.textSmallGrayColor),
              ),
              onSelected: (_) => setState(() => selectedSize = s.sizeLabel),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ColorPart extends StatefulWidget {
  final ProductDetailsEntity productDetails;
  const ColorPart({super.key, required this.productDetails});

  @override
  State<ColorPart> createState() => _ColorPartState();
}

class _ColorPartState extends State<ColorPart> {
  @override
  void initState() {
    super.initState();
    if (widget.productDetails.colors.isNotEmpty) {
      selectedColor = widget.productDetails.colors.first.colorName;
    }
  }

  String? selectedColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          EviraLang.of(context).color,
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: context.textColor,
          ),
        ),
        SizedBox(height: 10.h),
        Wrap(
          children: widget.productDetails.colors.map((c) {
            return ChoiceChip(
              label: Icon(
                Icons.check,
                color: selectedColor == c.colorName
                    ? AppUtils.parseHexColor(c.colorHex!) == Colors.white
                          ? Colors.black
                          : Colors.white
                    : Colors.transparent,
              ),
              showCheckmark: false,
              padding: EdgeInsets.all(9.h),
              backgroundColor: AppUtils.parseHexColor(c.colorHex!),
              selectedColor: AppUtils.parseHexColor(c.colorHex!),
              selected: selectedColor == c.colorName,
              shape: CircleBorder(
                side: BorderSide(color: context.textSmallGrayColor),
              ),
              onSelected: (_) => setState(() => selectedColor = c.colorName),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ProductInfoPart extends StatelessWidget {
  const ProductInfoPart({super.key, required this.productDetais});

  final ProductDetailsEntity productDetais;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: context.screenWidth * 0.75,
              child: Text(
                productDetais.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.urbanist(
                  fontSize: 30.sp,
                  color: context.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            FavoriteButton(
              size: 30.h,
              showBackground: false,
              heartColor: context.textColor,
              isFavorited: productDetais.isFavorite,
              onFavorited: () {
                getIt<WishlistService>().addProductToWishlist(productDetais.id);
              },
              onUnfavorited: () {
                getIt<WishlistService>().removeProductFromWishlist(
                  productDetais.id,
                );
              },
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: context.cardColor,
              ),
              child: Text.rich(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  text: productDetais.sold.toString(),
                  style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    color: context.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: ' ${EviraLang.of(context).sold}',
                      style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        color: context.textColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Icon(Icons.star, color: context.iconColor, size: 24.sp),
            SizedBox(width: 5.w),
            Text(
              productDetais.rate.toString(),
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                color: context.textSmallGrayColor,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}

class HeaderPart extends StatelessWidget {
  const HeaderPart({super.key, required this.productDetais});

  final ProductDetailsEntity? productDetais;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20.h,
        left: 20.w,
        right: 20.w,
      ),
      color: context.cardColor,
      height: context.screenHeight * 0.4,
      child: Stack(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              height: context.screenHeight * 0.4,
              clipBehavior: Clip.none,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
            ),
            itemCount: 5,
            itemBuilder: (context, itemIndex, pageViewIndex) {
              return CachedNetworkImage(
                imageUrl: productDetais!.imageUrl,
                height: context.screenHeight * 0.35,
                width: context.screenWidth * 0.8,
                fit: BoxFit.contain,
              );
            },
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 30.h,
                  constraints: BoxConstraints(minWidth: 48.h, minHeight: 48.h),
                  color: context.iconColor,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedSmoothIndicator(
                  activeIndex: 0,
                  count: 5,
                  effect: ExpandingDotsEffect(
                    dotWidth: 7.w,
                    dotHeight: 7.h,
                    activeDotColor: context.iconColor,
                    dotColor: context.hintColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ],
      ),
    );
  }
}
