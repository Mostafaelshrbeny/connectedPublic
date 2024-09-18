import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/ItemsGridCubit/items_in_grid_cubit.dart';
import 'package:elconnected/presentation/blocs/ItemsGridCubit/items_in_grid_state.dart';
import 'package:elconnected/presentation/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key, required this.arguments});
  final Map arguments;
  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((val) {
      ItemsInGridCubit.get(context).getWishList();
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
              : ItemsInGridCubit.get(context).wishItems == null ||
                      ItemsInGridCubit.get(context)
                          .wishItems!
                          .result!
                          .wishlistItems!
                          .isEmpty
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
                                .wishItems
                                ?.result
                                ?.wishlistItems?[index]
                                .items
                                ?.thumbnailUrl ??
                            '',
                        name: ItemsInGridCubit.get(context)
                                .wishItems
                                ?.result
                                ?.wishlistItems?[index]
                                .items
                                ?.name ??
                            "",
                        price: ItemsInGridCubit.get(context)
                                .wishItems
                                ?.result
                                ?.wishlistItems?[index]
                                .items
                                ?.price
                                .toString() ??
                            '',
                        id: ItemsInGridCubit.get(context)
                                .wishItems
                                ?.result
                                ?.wishlistItems?[index]
                                .items
                                ?.id ??
                            "0",
                      ),
                      itemCount: ItemsInGridCubit.get(context)
                              .wishItems
                              ?.result
                              ?.wishlistItems
                              ?.length ??
                          0,
                    ),
        );
      },
    );
  }
}
