import 'package:elconnected/constant/colors.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/widgets/homelist.dart';
import 'package:elconnected/presentation/widgets/hometopbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorHelper.pinkBackGroundColor,
          body: Padding(
            padding: EdgeInsets.only(
                top: Device.deviceStatusBar(context: context) + 10),
            child: ListView(
              padding: EdgeInsets.only(top: 0),
              children: const [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 16),
                  child: HomeTopBox(),
                ),
                Gap(16),
                HomeList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
