import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_recents_bloc.dart';
import 'package:evira_e_commerce/features/search/ui/widgets/keyword_item_part.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentKeywordsPart extends StatelessWidget {
  const RecentKeywordsPart({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchRecentsBloc, SearchRecentsState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is SearchRecentKeywordsError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        }
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is SearchRecentKeywordsLoading) {
          return const ShimmerRecentKeywords();
        } else if (state is SearchRecentKeywordsLoaded) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.keywords.length,
              (context, index) {
                final keyword = state.keywords[index];

                return KeywordItemPart(
                  onTap: (keywordText) {
                    _searchController.text = keywordText;
                  },
                  keyword: keyword.keyword,
                  id: keyword.id,
                );
              },
            ),
          );
        } else if (state is SearchRecentKeywordsError) {
          if (state.message == EviraLang.of(context).noInternetConnection) {
            return const ShimmerRecentKeywords();
          } else {
            return SliverToBoxAdapter(child: const SizedBox.shrink());
          }
        } else {
          return SliverToBoxAdapter(child: const SizedBox.shrink());
        }
      },
    );
  }
}

class ShimmerRecentKeywords extends StatelessWidget {
  const ShimmerRecentKeywords({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: 15, (context, index) {
        return ShimmerBox(
          height: 50.h,
          width: double.infinity,
          shimmerBaseColor: context.cardColor,
          margin: EdgeInsets.only(bottom: 10.h),
        );
      }),
    );
  }
}
