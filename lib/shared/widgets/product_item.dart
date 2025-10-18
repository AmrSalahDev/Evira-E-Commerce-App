import 'package:animated_digit/animated_digit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/wishlist/domain/services/wishlist_service.dart';
import 'package:evira_e_commerce/shared/domain/entities/product_entity.dart';
import 'package:evira_e_commerce/shared/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProductItem extends StatelessWidget {
  final ProductEntity product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              height: 200.h,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(30.r),
              ),

              child: LayoutBuilder(
                builder: (context, constraints) => CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.contain,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  alignment: Alignment.center,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: context.cardColor,
                    highlightColor: context.shimmerHighlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: context.cardColor,
                      ),
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              product.name,
              style: GoogleFonts.urbanist(
                fontSize: 20.sp,
                color: context.textColor,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.star, color: context.iconColor, size: 20.sp),
                SizedBox(width: 5.w),
                Text(
                  product.rate.toString(),
                  style: GoogleFonts.urbanist(
                    fontSize: 16.sp,
                    color: context.textColor,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 7.w),
                Text(
                  '|',
                  style: TextStyle(fontSize: 16.sp, color: context.textColor),
                ),
                SizedBox(width: 7.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: context.cardColor,
                  ),
                  child: Text.rich(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    TextSpan(
                      text: product.sold.toString(),
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
              ],
            ),
            SizedBox(height: 5.h),
            AnimatedDigitWidget(
              value: product.price,
              enableSeparator: true,
              separateSymbol: '.',
              fractionDigits: 2,
              prefix: '\$',
              textStyle: GoogleFonts.urbanist(
                fontSize: 20.sp,
                color: context.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Positioned(
          top: 12.h,
          right: 12.w,
          child: FavoriteButton(
            heartColor: Colors.white,
            isFavorited: product.isFavorite,
            size: 22.sp,
            onFavorited: () async {
              await getIt<WishlistService>().addProductToWishlist(product.id);
            },
            onUnfavorited: () async {
              await getIt<WishlistService>().removeProductFromWishlist(
                product.id,
              );
            },
          ),
        ),
      ],
    );
  }
}
