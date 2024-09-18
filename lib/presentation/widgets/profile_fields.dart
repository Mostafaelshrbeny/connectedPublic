import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/profile_model.dart';
import 'package:elconnected/presentation/blocs/ProfileCubit/profile_cubit.dart';
import 'package:elconnected/presentation/blocs/ProfileCubit/profile_state.dart';
import 'package:elconnected/presentation/widgets/phonetextfield.dart';
import 'package:elconnected/presentation/widgets/textfield_withlabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfileFields extends StatelessWidget {
  const ProfileFields({
    super.key,
    required this.userProfileData,
  });
  final ProfileModel userProfileData;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Gap(24),
              Row(
                children: [
                  Expanded(
                      child: TextFieldWithLabel(
                    onChange: (p0) {
                      ProfileCubit.get(context).changeName(true, p0);
                    },
                    fillColor: ProfileCubit.get(context).editPofile
                        ? null
                        : const Color.fromARGB(153, 239, 245, 255),
                    label: LocaleKeys.firstName.tr(),
                    hint: LocalePref.prefs!.getString("name"),
                    readOnly: !ProfileCubit.get(context).editPofile,
                  )),
                  const Gap(16),
                  Expanded(
                      child: TextFieldWithLabel(
                    onChange: (p0) {
                      ProfileCubit.get(context).changeName(false, p0);
                    },
                    fillColor: ProfileCubit.get(context).editPofile
                        ? null
                        : const Color.fromARGB(153, 239, 245, 255),
                    label: LocaleKeys.lastName.tr(),
                    hint: HiveLocaleData.myAppBox!.get("lastname"),
                    readOnly: !ProfileCubit.get(context).editPofile,
                  ))
                ],
              ),
              const Gap(24),
              TextFieldWithLabel(
                inputType: TextInputType.emailAddress,
                fillColor: const Color.fromARGB(153, 239, 245, 255),
                label: LocaleKeys.email.tr(),
                hint: userProfileData.result?.userProfile?.email,
                readOnly: true,
              ),
              const Gap(25),
              PhoneTextField(
                fillColor: const Color.fromARGB(153, 239, 245, 255),
                hint: userProfileData.result?.userProfile?.phoneNumber,
                readOnly: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
