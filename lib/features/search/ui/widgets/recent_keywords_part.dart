import 'package:evira_e_commerce/features/search/ui/blocs/search_recents_bloc.dart';
import 'package:evira_e_commerce/features/search/ui/widgets/keyword_item_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentKeywordsPart extends StatelessWidget {
  const RecentKeywordsPart({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchRecentsBloc, SearchRecentsState>(
      builder: (context, state) {
        if (state is SearchRecentKeywordsLoading) {
          return SliverToBoxAdapter(child: const SizedBox.shrink());
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
        } else {
          return SliverToBoxAdapter(child: const SizedBox.shrink());
        }
      },
    );
  }
}
