import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_cubit.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_state.dart';
import 'package:elconnected/presentation/widgets/allcatergories.dart';
import 'package:elconnected/presentation/widgets/custom_textfield.dart';
import 'package:elconnected/presentation/widgets/homeheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeTopBox extends StatelessWidget {
  const HomeTopBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: const HomeHeader(),
            ),
            BlocConsumer<MainLayerNavigationCubit, MainLayerNavigatonState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(top: 10, end: 16),
                  child: InkWell(
                    onTap: () =>
                        MainLayerNavigationCubit.get(context).navigate(1),
                    child: AbsorbPointer(
                      child: AppCustomTextField(
                        fillColor: const Color.fromRGBO(249, 250, 251, 1),
                        readonly: true,
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SvgPicture.asset(
                            "assets/images/Group 1000002762.svg",
                          ),
                        ),
                        hint: LocaleKeys.whatareyoulookingfor.tr(),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Gap(16),
            const AllCatergoriesPresent()
          ],
        );
      },
    );
  }
}
