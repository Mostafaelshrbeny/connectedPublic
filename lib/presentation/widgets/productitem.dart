import 'package:cached_network_image/cached_network_image.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/domain/use_cases/wishlist_items.dart';
import 'package:elconnected/presentation/blocs/DisplayItemCubit/dispaly_item_cubit.dart';
import 'package:elconnected/presentation/pages/itemdetailes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class AppProductItem extends StatelessWidget {
  const AppProductItem({
    super.key,
    this.itemWidth,
    this.imageFit,
    required this.image,
    this.isLiked = false,
    this.loveWithPadding = false,
    required this.name,
    required this.price,
    this.onlike,
    required this.id,
    this.withElevation = false,
    this.withColor = true,
  });

  final double? itemWidth;
  final BoxFit? imageFit;
  final String image, name, price, id;
  final bool isLiked, loveWithPadding, withElevation;
  final Function()? onlike;
  final bool withColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => DispalyItemCubit(),
                    child: ItemDetailesScreen(id: int.parse(id)),
                  ))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Material(
          color: withColor ? Colors.white : Colors.white.withOpacity(0.01),
          borderRadius: BorderRadius.circular(8),
          elevation: withElevation ? 8 : 0,
          shadowColor: Colors.black.withOpacity(0.25),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: withColor ? Colors.white : null,
            ),
            padding: const EdgeInsets.only(bottom: 8),
            width: itemWidth ??
                Device.deviceWidth(context: context, percent: 1 / 2.5),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: image,
                          imageBuilder: (context, imageProvider) => Container(
                            width: itemWidth ?? double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Container(
                              width: itemWidth ??
                                  Device.deviceWidth(
                                      context: context, percent: 1 / 2.8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Container(
                              width: itemWidth ??
                                  Device.deviceWidth(
                                      context: context, percent: 1 / 2.8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(8),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      child: Text(
                        name,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                    const Gap(4),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      child: Text(
                        "$price EGP",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: IconButton(
                      padding: EdgeInsetsDirectional.only(
                          end: loveWithPadding
                              ? Device.deviceWidth(
                                  context: context, percent: 1 / 20)
                              : 0),
                      onPressed: () {},
                      icon: InkWell(
                        onTap: onlike,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: FaIcon(
                            ItemActions.likedItems.contains(int.parse(id))
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color:
                                ItemActions.likedItems.contains(int.parse(id))
                                    ? Colors.red
                                    : Colors.grey,
                            size: 20,
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
