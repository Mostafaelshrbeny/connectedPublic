import 'dart:io';

import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/colors.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_cubit.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class UplaodMedia extends StatelessWidget {
  const UplaodMedia({
    super.key,
    required this.image,
    required this.type,
    required this.maxSize,
    required this.picked,
    this.pickedMedia,
    required this.isVideo,
  });
  final String image, type, maxSize;
  final bool picked;
  final List<XFile>? pickedMedia;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellOperationCubit, SellOperationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () => picked
              ? null
              : SellOperationCubit.get(context).pickMedia(isVideo: isVideo),
          child: Stack(
            children: [
              picked
                  ? SizedBox()
                  : RotationTransition(
                      turns: AlwaysStoppedAnimation(-2 / 360),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              ColorHelper.pinkBackGroundColor.withOpacity(0.5),
                        ),
                        height: Device.deviceHeight(
                            context: context,
                            percent: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 1 / 5
                                : 1 / 2.5),
                        width: double.infinity,
                      ),
                    ),
              Container(
                decoration: BoxDecoration(
                    border: picked
                        ? null
                        : Border.all(color: Colors.grey.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                height: Device.deviceHeight(
                    context: context,
                    percent: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 1 / 5
                        : 1 / 2.5),
                width: double.infinity,
                child: picked
                    ? (isVideo
                        ? InkWell(
                            onTap: () => SellOperationCubit.get(context)
                                .pickMedia(isVideo: true),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.cloud_done_sharp,
                                        color: Colors.green),
                                    Text(
                                      "Uploaded...click on Text to change",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        : Column(
                            children: [
                              Text(
                                "Tab to remove or tap + to change all and add more",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: List.generate(
                                      pickedMedia?.length ?? 0,
                                      (index) => InkWell(
                                        onTap: () =>
                                            SellOperationCubit.get(context)
                                                .removeImage(index),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            File(pickedMedia![index].path),
                                            height: Device.deviceHeight(
                                                context: context,
                                                percent: 1 / 13),
                                            width: Device.deviceHeight(
                                                context: context,
                                                percent: 1 / 13),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ) +
                                    [
                                      InkWell(
                                          onTap: () =>
                                              SellOperationCubit.get(context)
                                                  .pickMedia(isVideo: false),
                                          child: Container(
                                            height: Device.deviceHeight(
                                                context: context,
                                                percent: 1 / 13),
                                            width: Device.deviceHeight(
                                                context: context,
                                                percent: 1 / 13),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey),
                                            child: const Icon(Icons.add),
                                          ))
                                    ],
                              ),
                            ],
                          ))
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(image),
                            const Gap(10),
                            Text(
                              type,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: AppThemeData.appBlue),
                            ),
                            const Gap(10),
                            Text(
                              maxSize,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Colors.grey.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
