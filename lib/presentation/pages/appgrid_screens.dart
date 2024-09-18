import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/ItemsGridCubit/items_in_grid_cubit.dart';
import 'package:elconnected/presentation/blocs/ItemsGridCubit/items_in_grid_state.dart';
import 'package:elconnected/presentation/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridListScreens extends StatefulWidget {
  const GridListScreens({super.key, required this.arguments});
  final Map arguments;
  @override
  State<GridListScreens> createState() => _GridListScreensState();
}

class _GridListScreensState extends State<GridListScreens> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((val) {
      ItemsInGridCubit.get(context).getData(dataApi: widget.arguments['api']);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemsInGridCubit, ItemsInGridState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.arguments["title"],
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            centerTitle: true,
          ),
          body: ItemsInGridCubit.get(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppThemeData.appBlue,
                  ),
                )
              : ItemsInGridCubit.get(context).gridItemsList == null ||
                      ItemsInGridCubit.get(context).items.isEmpty
                  ? Center(
                      child: Text(
                        LocaleKeys.noItems.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: AppThemeData.appBlue),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 2.5),
                      itemBuilder: (context, index) => AppProductItem(
                        loveWithPadding: false,
                        image: ItemsInGridCubit.get(context)
                                .items[index]
                                .thumbnailUrl ??
                            '',
                        name: ItemsInGridCubit.get(context).items[index].name ??
                            "",
                        price: ItemsInGridCubit.get(context)
                            .items[index]
                            .price
                            .toString(),
                        id: ItemsInGridCubit.get(context).items[index].id!,
                      ),
                      itemCount: ItemsInGridCubit.get(context).items.length,
                    ),
        );
      },
    );
  }
}
