import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/models/profile_model.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_cubit.dart';
import 'package:elconnected/presentation/blocs/ProfileCubit/profile_cubit.dart';
import 'package:elconnected/presentation/blocs/ProfileCubit/profile_state.dart';
import 'package:elconnected/presentation/pages/mainlayer_screen.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/profile_fields.dart';
import 'package:elconnected/presentation/widgets/profileblueheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userProfileData});
  final ProfileModel userProfileData;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero)
        .then((val) => ProfileCubit.get(context).getProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is EditProfileDoneState) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(providers: [
                        BlocProvider(
                          create: (context) =>
                              MainLayerNavigationCubit()..navigate(4),
                        ),
                        BlocProvider(
                          create: (context) => HomeDataCubit(),
                        ),
                        BlocProvider(
                          create: (context) => ProfileCubit(),
                        ),
                      ], child: const MainLayerScreen())));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  ProfileCubit.get(context).editPofile
                      ? ProfileCubit.get(context).startEditing()
                      : Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: AppThemeData.appBlue,
                )),
            backgroundColor: const Color.fromARGB(153, 239, 245, 255),
            title: Text(
              ProfileCubit.get(context).profileTitle(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const ProfileBlueHeader(),
                ProfileFields(
                  userProfileData: widget.userProfileData,
                ),
                Gap(Device.deviceHeight(
                    context: context,
                    percent: 1 /
                        (ProfileCubit.get(context).editPofile ? 5.6 : 4.2))),
                ProfileCubit.get(context).loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppThemeData.appBlue,
                        ),
                      )
                    : AppCustomButton(
                        buttonPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        buttonChild: Text(
                          ProfileCubit.get(context).editPofile
                              ? LocaleKeys.save.tr()
                              : LocaleKeys.editProfile.tr(),
                          style: AppThemeData.buttonTextThem(context),
                        ),
                        ontap: () {
                          ProfileCubit.get(context).editPofile
                              ? ProfileCubit.get(context).saveData()
                              : ProfileCubit.get(context).startEditing();
                        })
              ],
            ),
          ),
        );
      },
    );
  }
}
