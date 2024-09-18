import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/SearchCubit/search_items_cubit.dart';
import 'package:elconnected/presentation/blocs/SearchCubit/search_items_state.dart';
import 'package:elconnected/presentation/widgets/popularsearch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PopularSearches extends StatelessWidget {
  const PopularSearches({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var keyWordsList =
        SearchItemsCubit.get(context).recentSearch?.result?.keywords;
    return BlocConsumer<SearchItemsCubit, SearchItemsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SearchItemsCubit.get(context).recentSearch == null ||
                keyWordsList == null ||
                SearchItemsCubit.get(context).loading
            ? const SizedBox()
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  keyWordsList.length,
                  (index) => InkWell(
                    onTap: () => (
                      SearchItemsCubit.get(context).searchItem(
                          keywords: keyWordsList[index].searchQuery ?? ''),
                      SearchItemsCubit.get(context).setSearch(
                          keyWordsList[index].searchQuery?.toString() ?? "")
                    ),
                    child: PopularSearchesCard(
                      searchKeyWord:
                          keyWordsList[index].searchQuery?.toString() ?? "",
                    ),
                  ),
                ).toList(),
              );
      },
    );
  }
}
