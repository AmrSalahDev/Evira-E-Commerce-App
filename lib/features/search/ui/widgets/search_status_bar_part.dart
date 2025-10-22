import 'package:animated_digit/animated_digit.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_recents_bloc.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_results_bloc.dart'
    hide ClearAllRecentKeywordsEvent;
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class SearchStatusBarPart extends StatelessWidget {
  final String keyword;
  const SearchStatusBarPart({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return context.read<SearchResultsBloc>().isSearchResult
        ? BlocBuilder<SearchResultsBloc, SearchResultsState>(
            builder: (context, state) {
              if (state is SearchResultLoading) {
                return ShimmerBox(
                  height: 50.h,
                  width: context.screenWidth,
                  shimmerBaseColor: context.cardColor,
                );
              } else if (state is SearchResultLoaded) {
                return Row(
                  children: [
                    Text(
                      '${EviraLang.of(context).resultsfor} "$keyword"',
                      style: GoogleFonts.urbanist(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: context.textColor,
                      ),
                    ),
                    const Spacer(),
                    AnimatedDigitWidget(
                      value: state.products.length,
                      enableSeparator: true,
                      suffix: ' ${EviraLang.of(context).found}',
                      textStyle: GoogleFonts.urbanist(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textColor,
                      ),
                    ),
                  ],
                );
              } else if (state is SearchResultError) {
                if (state.message ==
                    EviraLang.of(context).noInternetConnection) {
                  return ShimmerBox(
                    height: 50.h,
                    width: context.screenWidth,
                    shimmerBaseColor: context.cardColor,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        : BlocBuilder<SearchRecentsBloc, SearchRecentsState>(
            builder: (context, state) {
              if (state is SearchRecentKeywordsLoading) {
                return ShimmerBox(
                  height: 50.h,
                  width: context.screenWidth,
                  shimmerBaseColor: context.cardColor,
                );
              } else if (state is SearchRecentKeywordsLoaded) {
                return Row(
                  children: [
                    Text(
                      EviraLang.of(context).recent,
                      style: GoogleFonts.urbanist(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: context.textColor,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => context.read<SearchRecentsBloc>().add(
                        ClearAllRecentKeywordsEvent(),
                      ),
                      child: Text(
                        EviraLang.of(context).clearAll,
                        style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: context.textColor,
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is SearchRecentKeywordsError) {
                if (state.message ==
                    EviraLang.of(context).noInternetConnection) {
                  return ShimmerBox(
                    height: 50.h,
                    width: context.screenWidth,
                    shimmerBaseColor: context.cardColor,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              } else {
                return const SizedBox.shrink();
              }
            },
          );
  }
}
