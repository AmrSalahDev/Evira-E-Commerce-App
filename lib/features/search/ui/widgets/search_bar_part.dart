import 'package:evira_e_commerce/features/search/domain/entities/search_recent_keywords_entity.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_recents_bloc.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_results_bloc.dart'
    hide AddRecentKeywordEvent, GetRecentKeywordsEvent;
import 'package:evira_e_commerce/features/search/ui/widgets/custom_search_bar_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarPart extends StatelessWidget {
  const SearchBarPart({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        BlocSelector<
          SearchRecentsBloc,
          SearchRecentsState,
          List<SearchRecentKeywordsEntity>
        >(
          selector: (state) {
            return state is SearchRecentKeywordsLoaded ? state.keywords : [];
          },
          builder: (context, keywords) {
            return CustomSearchBarPart(
              controller: _searchController,
              keywords: keywords,
              onSearch: (keyword) {
                context.read<SearchRecentsBloc>().add(
                  GetRecentKeywordsEvent(keyword),
                );
              },
              onSubmitted: (keyword) {
                context.read<SearchResultsBloc>().add(
                  SearchResultEvent(keyword),
                );
                context.read<SearchRecentsBloc>().add(
                  AddRecentKeywordEvent(keyword),
                );
              },
            );
          },
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
