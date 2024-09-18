import 'package:cached_network_image/cached_network_image.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_cubit.dart';
import 'package:elconnected/presentation/pages/categorypresent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBox extends StatelessWidget {
  const CategoryBox(
      {super.key,
      required this.index,
      required this.width,
      this.background = Colors.white,
      required this.image,
      required this.name,
      required this.id});
  final int index;
  final double width;
  final Color background;
  final String image, name, id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => SubCatergoriesCubit(),
                    child: CategoryPresentScreen(
                      id: id,
                      name: name,
                    ),
                  ))),
      child: Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? Device.deviceHeight(context: context, percent: 1 / 9)
            : Device.deviceHeight(context: context, percent: 1 / 6),
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: background),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: Device.deviceWidth(
                          context: context, percent: 1 / 26)),
                ),
              ),
            ),
            Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => const SizedBox(),
                  imageBuilder: (context, imageProvider) => Image(
                    image: imageProvider,
                    height: index == 1
                        ? Device.deviceHeight(
                            context: context, percent: 1 / 11.5)
                        : Device.deviceHeight(
                            context: context, percent: 1 / 13.5),
                  ),
                  errorWidget: (context, url, error) => const SizedBox(),
                ))
          ],
        ),
      ),
    );
  }
}
