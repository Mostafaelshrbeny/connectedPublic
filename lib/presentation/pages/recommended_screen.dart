import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/RecomnededCubit/recommended_foryou_cubit.dart';
import 'package:elconnected/presentation/blocs/RecomnededCubit/recommended_foryou_state.dart';
import 'package:elconnected/presentation/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendedScreen extends StatefulWidget {
  const RecommendedScreen({super.key});

  @override
  State<RecommendedScreen> createState() => _RecommendedScreenState();
}

class _RecommendedScreenState extends State<RecommendedScreen> {
  @override
  void initState() {
    scControll.addListener(scrollListener);
    RecommendedForyouCubit.get(context).getRecommended(0);
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controller to avoid memory leaks
    scControll.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scControll.offset >= scControll.position.maxScrollExtent - 200 &&
        !scControll.position.outOfRange) {
      RecommendedForyouCubit.get(context).scroll();
    }
  }

  ScrollController scControll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecommendedForyouCubit, RecommendedForyouState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.recommendedforyou.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            centerTitle: true,
          ),
          body: RecommendedForyouCubit.get(context).loading &&
                  RecommendedForyouCubit.get(context).items.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppThemeData.appBlue,
                  ),
                )
              : RecommendedForyouCubit.get(context).recommendedforItems ==
                          null ||
                      RecommendedForyouCubit.get(context).items.isEmpty
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
                      controller: scControll,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 2.5),
                      itemBuilder: (context, index) => AppProductItem(
                        onlike: () {
                          RecommendedForyouCubit.get(context).likeProduct(
                              int.parse(RecommendedForyouCubit.get(context)
                                  .items[index]
                                  .id!));
                          RecommendedForyouCubit.get(context).addtoList(
                              int.parse(RecommendedForyouCubit.get(context)
                                  .items[index]
                                  .id!));
                        },
                        loveWithPadding: true,
                        image: RecommendedForyouCubit.get(context)
                                .items[index]
                                .thumbnailUrl ??
                            '',
                        name: RecommendedForyouCubit.get(context)
                                .items[index]
                                .name ??
                            "",
                        price: RecommendedForyouCubit.get(context)
                            .items[index]
                            .price
                            .toString(),
                        id: RecommendedForyouCubit.get(context)
                            .items[index]
                            .id!,
                      ),
                      itemCount:
                          RecommendedForyouCubit.get(context).items.length,
                    ),
        );
      },
    );
  }
}
