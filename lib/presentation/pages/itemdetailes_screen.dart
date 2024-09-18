import 'package:dynamic_fa_icons/dynamic_fa_icons.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/colors.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/models/item_details_model.dart';
import 'package:elconnected/presentation/blocs/DisplayItemCubit/dispaly_item_cubit.dart';
import 'package:elconnected/presentation/blocs/DisplayItemCubit/dispaly_item_state.dart';
import 'package:elconnected/presentation/widgets/item_ownerinfo.dart';
import 'package:elconnected/presentation/widgets/itemdiscription_text.dart';
import 'package:elconnected/presentation/widgets/itemimages_display.dart';
import 'package:elconnected/presentation/widgets/itemprice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gap/gap.dart';

class ItemDetailesScreen extends StatefulWidget {
  const ItemDetailesScreen({super.key, required this.id});
  final int id;
  @override
  State<ItemDetailesScreen> createState() => _ItemDetailesScreenState();
}

class _ItemDetailesScreenState extends State<ItemDetailesScreen> {
  @override
  void initState() {
    print(widget.id);
    DispalyItemCubit.get(context).viewItem(widget.id);
    DispalyItemCubit.get(context).getItemDetails(widget.id);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // status bar color
    ));
    super.initState();
  }

  Item? detailes;
  @override
  Widget build(BuildContext context) {
    final controller = PageController(keepPage: true);
    List<Specifications>? owner;

    return BlocConsumer<DispalyItemCubit, DispalyItemState>(
      listener: (context, state) {
        if (state is GetItemDataDone) {
          detailes = DispalyItemCubit.get(context).itemData?.result?.item;
          owner = DispalyItemCubit.get(context)
              .itemData
              ?.result
              ?.item
              ?.specifications
              ?.where(
                  (element) => element.specificationId!.contains("developer"))
              .toList();
          print(owner?[0].name ?? "none");
          detailes?.specifications?.removeWhere(
              (element) => element.specificationId!.contains("developer"));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: DispalyItemCubit.get(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppThemeData.appBlue,
                ))
              : DispalyItemCubit.get(context).itemData == null ||
                      detailes == null
                  ? Center(
                      child: Text(
                        "Something went wrong",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: AppThemeData.appBlue),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          top: Device.deviceStatusBar(context: context) + 10),
                      child: ListView(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          children: [
                            ItemImageDisplay(
                              controller: controller,
                              itemImages: detailes?.media ?? [],
                              id: widget.id,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Gap(24),
                                  Text(detailes?.title ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge),
                                  // const Gap(7),
                                  // const ItemFeaturesRow(),
                                  const Gap(16),
                                  ItemPriceCard(
                                    price: detailes?.price ?? "0.00",
                                  ),
                                  const Gap(16),
                                  ItemDiscriptionText(
                                    description: detailes?.description ?? '',
                                  ),
                                  const Gap(24),
                                  detailes?.specifications == null ||
                                          detailes!.specifications!.isEmpty ||
                                          owner!.isEmpty
                                      ? const SizedBox()
                                      : OwnerInfo(
                                          ownerRole:
                                              owner?[0].specificationId ?? "",
                                          ownerName: owner?[0].name ?? "none",
                                          actionText: "See Profile",
                                          actionurl: owner?[0]
                                                  .specificationValues?[0]
                                                  .website ??
                                              "",
                                          imageUrl: owner?[0]
                                                  .specificationValues?[0]
                                                  .logoUrl ??
                                              '',
                                        ),
                                ],
                              ),
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    color: index % 2 == 0
                                        ? ColorHelper.pinkBackGroundColor
                                            .withOpacity(0.4)
                                        : null,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            detailes
                                                        ?.specifications?[index]
                                                        .specificationValues?[0]
                                                        .fontAwesomeIcon ==
                                                    null
                                                ? SizedBox()
                                                : FaIcon(
                                                    DynamicFaIcons
                                                        .getIconFromName(detailes!
                                                            .specifications![
                                                                index]
                                                            .specificationValues![
                                                                0]
                                                            .fontAwesomeIcon!),
                                                    color: AppThemeData.appBlue,
                                                  ),
                                            Text(
                                                detailes?.specifications?[index]
                                                        .name ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium),
                                            Text(" :",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: Device.deviceWidth(
                                                  context: context,
                                                  percent: 1 / 1.8)),
                                          child: Text(
                                              detailes
                                                      ?.specifications?[index]
                                                      .specificationValues?[0]
                                                      .value ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => Gap(0),
                                itemCount:
                                    detailes?.specifications?.length ?? 0)
                          ]
                          //  +
                          // List.generate(
                          //   detailes.specifications?.length ?? 0,
                          //   (index) => Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 20, horizontal: 16),
                          //     child: ,
                          //   ),
                          // )
                          // [
                          //   AppCustomButton(
                          //       buttonPadding:
                          //           const EdgeInsets.symmetric(horizontal: 16),
                          //       buttonChild: Text(LocaleKeys.contactOwner.tr()),
                          //       ontap: () {})
                          // ],
                          ),
                    ),
        );
      },
    );
  }
}

/*
// const Gap(12),
                              // const OwnerInfo(
                              //   ownerRole: "Project",
                              //   ownerName: "Sarai",
                              //   actionText: "See Units",
                              //   actionurl: '',
                              // ),
                              const Gap(12),
                              Text(LocaleKeys.location.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              const Gap(8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                    "assets/images/Frame 1261155428.png",
                                    width: double.infinity,
                                    height: Device.deviceHeight(
                                        context: context, percent: 1 / 4),
                                    fit: BoxFit.cover),
                              ),
                              const Gap(12),
                              Text(LocaleKeys.amenities.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              const Gap(8),
                              const ItemAmenitiesRow(),
                              const Gap(12),
                              const ItemMoreInfo(),
                              Gap(Device.deviceHeight(
                                  context: context, percent: 1 / 15)),


*/
