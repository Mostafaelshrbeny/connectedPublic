import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/domain/use_cases/sellbottomsheet.dart';
import 'package:elconnected/domain/use_cases/sign_in_later_dialog.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellProductScreen extends StatefulWidget {
  const SellProductScreen({super.key});

  @override
  State<SellProductScreen> createState() => _SellProductScreenState();
}

class _SellProductScreenState extends State<SellProductScreen> {
  @override
  void initState() {
    HiveLocaleData.myAppBox!.get('notuser')
        ? Future.delayed(Duration.zero).then((val) =>
            SignInLaterDialog.signInDialog(context,
                () => MainLayerNavigationCubit.get(context).navigate(0)))
        : Future.delayed(Duration.zero)
            .then((value) => SellBottomSheet.sellSheet(
                  context: context,
                  categories: HomeDataCubit.get(context).catergories!,
                ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return const Scaffold();
      },
    );
  }
}
