import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_state.dart';
import 'package:elconnected/presentation/blocs/SearchCubit/search_items_cubit.dart';
import 'package:elconnected/presentation/pages/account_screen.dart';
import 'package:elconnected/presentation/pages/explore_screen.dart';
import 'package:elconnected/presentation/pages/homescreen.dart';
import 'package:elconnected/presentation/pages/searchscreen.dart';
import 'package:elconnected/presentation/pages/sellproduct_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayerNavigationCubit extends Cubit<MainLayerNavigatonState> {
  MainLayerNavigationCubit() : super(MainLayerNavigatonInitial());
  static MainLayerNavigationCubit get(context) => BlocProvider.of(context);
  int currentPage = 0;
  List<Widget> pages = [
    const HomeScreen(),
    BlocProvider(
      create: (context) => SearchItemsCubit(),
      child: const SearchScreen(),
    ),
    const SellProductScreen(),
    const ExploreScreen(),
    const AccountScreen()
  ];
  navigate(int index) {
    currentPage = index;
    emit(MainLayerNavigateState());
  }

  appVersionCheck() async {
    final dio = Dio();
    try {
      final response =
          await dio.get(ApiConstant.baseUrl + ApiConstant.bootstrap,
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': LocalePref.prefs!.getString("token")
                },
              ));
      print(response.data);
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }
}
