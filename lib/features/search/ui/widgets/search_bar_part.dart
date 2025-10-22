import 'package:evira_e_commerce/features/search/domain/entities/search_recent_keywords_entity.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_recents_bloc.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_results_bloc.dart'
    hide AddRecentKeywordEvent, GetRecentKeywordsEvent;
import 'package:evira_e_commerce/features/search/ui/cubit/filter_cubit.dart';
import 'package:evira_e_commerce/features/search/ui/widgets/custom_search_bar_part.dart';
import 'package:evira_e_commerce/features/search/ui/widgets/filter_bottom_sheet_part.dart';
import 'package:evira_e_commerce/shared/cubits/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarPart extends StatefulWidget {
  const SearchBarPart({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  State<SearchBarPart> createState() => _SearchBarPartState();
}

class _SearchBarPartState extends State<SearchBarPart> {
  @override
  void initState() {
    super.initState();
  }

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
              controller: widget._searchController,
              keywords: keywords,
              onFilterTap: (String keyword) =>
                  _showFilterBottomSheet(context, keyword),
              onSearch: (keyword) {
                context.read<SearchRecentsBloc>().add(
                  GetRecentKeywordsEvent(keyword),
                );
              },
              onSubmitted: (keyword) {
                context.read<SearchRecentsBloc>().add(
                  AddRecentKeywordEvent(keyword),
                );
                context.read<SearchResultsBloc>().add(
                  SearchResultEvent(keyword),
                );
              },
            );
          },
        ),
        SizedBox(height: 30.h),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context, String keyword) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black38,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.95,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<CategoryCubit>()),
            BlocProvider.value(value: context.read<FilterCubit>()),
            BlocProvider.value(value: context.read<SearchRecentsBloc>()),
          ],
          child: FilterBottomSheetPart(
            keyword: keyword,
            parentContext: context,
          ),
        ),
      ),
    );
  }
}
