import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/allcategories_model.dart';
import 'package:elconnected/data/models/banner_model.dart';
import 'package:elconnected/data/models/collection_model.dart';
import 'package:elconnected/data/models/explore_collection_model.dart';
import 'package:elconnected/data/models/home_collection_model.dart';
import 'package:elconnected/data/models/merchants_model.dart';
import 'package:elconnected/data/models/profile_model.dart';
import 'package:elconnected/data/models/recommended_model.dart';
import 'package:elconnected/domain/use_cases/save_token.dart';
import 'package:elconnected/domain/use_cases/wishlist_items.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/explore_collections.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/homedata_methods.dart';
import 'package:elconnected/presentation/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDataCubit extends Cubit<HomeDataState> {
  HomeDataCubit() : super(HomeDataInitial());
  static HomeDataCubit get(context) => BlocProvider.of(context);

  AllCategoriesModel? catergories;
  final dio = Dio();
  MerchantsModel? merchants;
  BannerModel? allBanners;
  ExploreCollectionModel? hotDeals;
  RecommendedItemsModel? recommendedItems;
  HomeCollectionModel? homeCollection;
  List<Widget> allExploreItems = [];
  bool loading = true;
  ProfileModel? userProfile;

  getAllHomeData() async {
    emit(GetHomeDataLoaingState());
    loading = true;
    try {
      catergories = await HomeDataMethods.getCategories();
      merchants = await HomeDataMethods.getMerchants();
      HiveLocaleData.myAppBox!.get('notuser')
          ? null
          : recommendedItems =
              await HomeDataMethods.getRecommended(skip: 0, max: 10);
      homeCollection = await HomeDataMethods.getHomecollection();
      loading = false;
      print(
          "+++++++++++++++++++++++++++homeCollection+++++++++++++++++++++++++++");
      print(
          homeCollection?.result ?? "+55555+++++++++++55555555555555++++++++");
      print(
          "+++++++++++++++++++++++++++homeCollection+++++++++++++++++++++++++++");
      await getBanners();
      emit(GetHomeDataDoneState());
    } on DioException catch (e) {
      merchants = null;
      catergories = null;
      recommendedItems = null;
      print(e.response);
      loading = false;
      emit(GetHomeDataFailedState());
    }
  }

  getExploreData(BuildContext context) async {
    try {
      if (context.mounted) {
        hotDeals = await ExploreCollections.getHotDeals();
        allExploreItems = ExploreCollections.generateWidget(hotDeals, context);
        print(hotDeals);
      }
      emit(GetExploreDataDoneState());
    } on DioException catch (e) {
      print("Error $e");
    }
  }

  getProfile() async {
    emit(GetProfileLoadingState());
    try {
      final response = await dio.get(ApiConstant.baseUrl + ApiConstant.account,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      print(response.data);
      userProfile = ProfileModel.fromJson(response.data);
      SaveUserData.savedata(userProfile);
      emit(GetProfileDoneState());
    } on DioException catch (e) {
      print(e.response);
      print('+++++++++++++++++++++++++++++');
      emit(GetProfileFailedState());
    }
  }

  getBanners() async {
    try {
      final response = await dio.get(ApiConstant.baseUrl + ApiConstant.banners,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      allBanners = BannerModel.fromJson(response.data);
      print(response.data);
      emit(GetBannersDoneState());
    } on DioException catch (e) {
      print(e.response);
      emit(GetBannersFailedState());
    }
  }

  addtoList(int id) {
    ItemActions.addItem(id);
    emit(LikeItemDone());
  }

  likeProduct(int id) async {
    try {
      await dio.post("${ApiConstant.baseUrl}/mobile/api/items/$id/wishlist",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }),
          data: {});
      emit(LikeItemDone());
    } on DioException catch (e) {
      print(e.response);
      emit(LikeItemFailed());
    }
  }
}

class ExploreGridItems extends StatelessWidget {
  const ExploreGridItems({super.key, required this.allitems});
  final List<ItemsIn> allitems;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 15,
            childAspectRatio: 2 / 2.5,
            crossAxisCount: 2),
        itemBuilder: (context, index) => AppProductItem(
          withColor: false,
          loveWithPadding: true,
          image: allitems[index].thumbnailUrl!,
          name: allitems[index].name!,
          price: allitems[index].price.toString(),
          id: allitems[index].id!,
        ),
        itemCount: allitems.length > 4 ? 4 : allitems.length,
      ),
    );
  }
}
