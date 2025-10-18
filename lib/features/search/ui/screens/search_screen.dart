import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/routes/args/no_internet_screen_args.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_recents_bloc.dart';
import 'package:evira_e_commerce/features/search/ui/blocs/search_results_bloc.dart'
    hide GetRecentKeywordsEvent;
import 'package:evira_e_commerce/features/search/ui/widgets/recent_keywords_part.dart';
import 'package:evira_e_commerce/features/search/ui/widgets/search_bar_part.dart';
import 'package:evira_e_commerce/features/search/ui/widgets/search_result_part.dart';
import 'package:evira_e_commerce/features/search/ui/widgets/search_status_bar_part.dart';
import 'package:evira_e_commerce/shared/cubits/category_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/network_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with StatefulScreenMixin {
  late final TextEditingController _searchController;

  @override
  bool get showAppBar => false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<CategoryCubit>().loadCategories();
    context.read<SearchRecentsBloc>().add(GetRecentKeywordsEvent(null));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected) {
          context.go(
            AppPaths.noInternet,
            extra: NoInternetScreenArgs(targetPath: AppPaths.search),
          );
        }
      },
      child: CustomScrollView(
        clipBehavior: Clip.none,
        slivers: [
          SliverStickyHeader(
            header: Container(
              color: context.backgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SearchBarPart(searchController: _searchController),
                  SearchStatusBarPart(keyword: _searchController.text),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Divider(color: context.dividerColor, thickness: 1.5),
                  ),
                ],
              ),
            ),
            sliver: context.read<SearchResultsBloc>().isSearchResult
                ? SearchResultPart(keyword: _searchController.text)
                : RecentKeywordsPart(searchController: _searchController),
          ),
        ],
      ),
    );
  }
}
