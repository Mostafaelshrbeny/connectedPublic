import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/SectionDataCubit/sections_data_cubit.dart';
import 'package:elconnected/presentation/blocs/SectionDataCubit/sections_data_state.dart';
import 'package:elconnected/presentation/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SctionsScreen extends StatefulWidget {
  const SctionsScreen({super.key, required this.id, required this.name});
  final int id;
  final String name;
  @override
  State<SctionsScreen> createState() => _SctionsScreenState();
}

class _SctionsScreenState extends State<SctionsScreen> {
  @override
  void initState() {
    scControll.addListener(scrollListener);
    Future.delayed(Duration.zero).then(
        (val) => SectionsDataCubit.get(context).getSectionData(widget.id));
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
      SectionsDataCubit.get(context).scroll(widget.id);
    }
  }

  ScrollController scControll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SectionsDataCubit, SectionsDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.name,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            centerTitle: true,
          ),
          body: SectionsDataCubit.get(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppThemeData.appBlue,
                  ),
                )
              : SectionsDataCubit.get(context).itemList.isEmpty
                  ? Center(
                      child: Text(
                        LocaleKeys.noItems.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
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
                        image: SectionsDataCubit.get(context)
                                .itemList[index]
                                .thumbnailUrl ??
                            '',
                        name: SectionsDataCubit.get(context)
                                .itemList[index]
                                .name ??
                            "",
                        price: SectionsDataCubit.get(context)
                            .itemList[index]
                            .price
                            .toString(),
                        id: SectionsDataCubit.get(context).itemList[index].id!,
                      ),
                      itemCount: SectionsDataCubit.get(context).itemList.length,
                    ),
        );
      },
    );
  }
}
