import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/domain/use_cases/upload_image.dart';
import 'package:elconnected/presentation/blocs/ProfileCubit/profile_cubit.dart';
import 'package:elconnected/presentation/blocs/ProfileCubit/profile_state.dart';
import 'package:elconnected/presentation/widgets/profilepicture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBlueHeader extends StatelessWidget {
  const ProfileBlueHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
            width: double.infinity,
            color: const Color.fromARGB(153, 239, 245, 255),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfilePicture(
                  fromDevice: UploadImage.image != null,
                  pictureRadiusPercent: 20,
                  imageUrl: HiveLocaleData.myAppBox?.get("pic") ?? "",
                ),
                ProfileCubit.get(context).editPofile
                    ? TextButton(
                        onPressed: () {
                          ProfileCubit.get(context).pickImage();
                        },
                        child: Text(LocaleKeys.changePhoto.tr()))
                    : const SizedBox()
              ],
            ));
      },
    );
  }
}
