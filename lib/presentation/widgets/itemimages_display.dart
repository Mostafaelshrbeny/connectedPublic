import 'package:cached_network_image/cached_network_image.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/domain/use_cases/sign_in_later_dialog.dart';
import 'package:elconnected/domain/use_cases/wishlist_items.dart';
import 'package:elconnected/presentation/blocs/DisplayItemCubit/dispaly_item_cubit.dart';
import 'package:elconnected/presentation/blocs/DisplayItemCubit/dispaly_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemImageDisplay extends StatelessWidget {
  const ItemImageDisplay({
    super.key,
    required this.controller,
    required this.itemImages,
    required this.id,
  });

  final PageController controller;
  final List<String> itemImages;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DispalyItemCubit, DispalyItemState>(
      listener: (context, state) {
        if (state is ShareItemDone) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Item Shared Successfully"),
            backgroundColor: Colors.green,
          ));
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: Device.deviceWidth(context: context),
          width: double.infinity,
          child: Stack(
            children: [
              PageView.builder(
                controller: controller,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: itemImages[index],
                    imageBuilder: (context, imageProvider) => Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => const SizedBox(),
                    placeholder: (context, url) => Expanded(
                        child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey,
                      child: Container(
                        color: Colors.grey,
                      ),
                    )),
                  ),
                ),
                itemCount: itemImages.length,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: itemImages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.white,
                      dotColor: Colors.white.withOpacity(0.7),
                      dotHeight: 7,
                      dotWidth: 7,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          HiveLocaleData.myAppBox?.get('notuser')
                              ? SignInLaterDialog.signInDialog(context, () {})
                              : (
                                  DispalyItemCubit.get(context).like(id),
                                  DispalyItemCubit.get(context).likeProduct(id)
                                );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: FaIcon(
                            ItemActions.likedItems.contains(id)
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: ItemActions.likedItems.contains(id)
                                ? Colors.red
                                : Colors.grey,
                            size: 22,
                          ),
                        ),
                      ),
                      const Gap(8),
                      InkWell(
                        onTap: () =>
                            DispalyItemCubit.get(context).shareItem(id),
                        child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: FaIcon(
                              FontAwesomeIcons.paperPlane,
                              color: Colors.black,
                              size: 18,
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
