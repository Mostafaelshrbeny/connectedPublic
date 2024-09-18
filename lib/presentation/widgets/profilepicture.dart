import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/domain/use_cases/upload_image.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    this.pictureRadiusPercent = 35,
    required this.imageUrl,
    this.fromDevice = false,
  });
  final double pictureRadiusPercent;
  final String imageUrl;
  final bool fromDevice;
  @override
  Widget build(BuildContext context) {
    return fromDevice
        ? CircleAvatar(
            backgroundColor: Colors.white,
            radius: Device.deviceHeight(
                context: context, percent: 1 / (pictureRadiusPercent - 1)),
            child: CircleAvatar(
              radius: Device.deviceHeight(
                  context: context, percent: 1 / pictureRadiusPercent),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(UploadImage.image!.path),
                    fit: BoxFit.cover,
                    height: Device.deviceHeight(
                        context: context,
                        percent: 1 / (pictureRadiusPercent - 1) * 2),
                    width: Device.deviceHeight(
                        context: context,
                        percent: 1 / (pictureRadiusPercent - 1) * 2),
                  )),
            ),
          )
        : CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundColor: Colors.white,
              radius: Device.deviceHeight(
                  context: context, percent: 1 / (pictureRadiusPercent - 1)),
              child: CircleAvatar(
                backgroundImage: imageProvider,
                radius: Device.deviceHeight(
                    context: context, percent: 1 / pictureRadiusPercent),
              ),
            ),
            errorWidget: (context, url, error) {
              print(error);
              return CircleAvatar(
                backgroundColor: Colors.white,
                radius: Device.deviceHeight(
                    context: context, percent: 1 / (pictureRadiusPercent - 1)),
                child: CircleAvatar(
                  backgroundImage:
                      const AssetImage("assets/images/NoProfile.png"),
                  radius: Device.deviceHeight(
                      context: context, percent: 1 / pictureRadiusPercent),
                ),
              );
            },
            placeholder: (context, url) => CircleAvatar(
              backgroundColor: Colors.white,
              radius: Device.deviceHeight(
                  context: context, percent: 1 / (pictureRadiusPercent - 1)),
              child: CircleAvatar(
                backgroundImage:
                    const AssetImage("assets/images/NoProfile.png"),
                radius: Device.deviceHeight(
                    context: context, percent: 1 / pictureRadiusPercent),
              ),
            ),
          );
  }
}
