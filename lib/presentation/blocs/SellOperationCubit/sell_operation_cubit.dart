import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/models/sellitem_model.dart';
import 'package:elconnected/domain/use_cases/sell_details.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/generate_sell_page.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SellOperationCubit extends Cubit<SellOperationState> {
  SellOperationCubit() : super(SellOperationInitial());
  static SellOperationCubit get(context) => BlocProvider.of(context);
  SellitemModel? sellSpecifications;
  List<String> requiredItems = [];
  bool loading = false;
  Widget? sellreq;
  bool uploadmedialoading = false;
  int selectedItem = -1;
  final dio = Dio();
  List<XFile> images = [];
  XFile? video;
  selectProductType(int typeIndex) {
    selectedItem = typeIndex;
    emit(TypeSelectedState());
  }

  pickMedia({required bool isVideo}) async {
    uploadmedialoading = true;
    emit(PickedMediaLoadingState());
    final ImagePicker picker = ImagePicker();
    if (isVideo) {
      video = await picker.pickVideo(source: ImageSource.gallery);
      video == null
          ? null
          : await SellDetails.setMedia(ximages: null, xFilevideos: [video!]);
    } else {
      images = await picker.pickMultipleMedia(imageQuality: 25);
      images.isEmpty
          ? null
          : await SellDetails.setMedia(ximages: images, xFilevideos: null);
    }
    uploadmedialoading = false;
    emit(PickedMediaState());
  }

  getSellRequirement(String id, BuildContext context) async {
    loading = true;
    emit(GetReqLoadingState());
    try {
      final response = await dio.get(
          "${ApiConstant.baseUrl}/mobile/api/categories/$id/specifications",
          options: Options(headers: ApiConstant.headers));
      sellSpecifications = SellitemModel.fromJson(response.data);
      print("+++++++++++++++++++++++++++++++++++++++++++++");
      print(response.data);
      print("+++++++++++++++++++++++++++++++++++++++++++++");
      print("+++++++++++++++++++++++++++++++++++++++++++++");
      //print(sellSpecifications);
      List<Specifications> detailsList =
          sellSpecifications?.result?.specifications ?? [];
      for (var element in detailsList) {
        if (element.isRequired ?? true) {
          requiredItems.add(element.id!);
        }
      }
      print(requiredItems);
      sellreq = BlocConsumer<SellOperationCubit, SellOperationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: List<Widget>.generate(
                detailsList.length,
                (index) => BlocConsumer<SellOperationCubit, SellOperationState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return GenerateSellPage.selectWidgetCase(
                            detailsList[index].type ?? "Profile",
                            detailsList[index],
                            index);
                      },
                    )).toList(),
          );
        },
      );
      loading = false;
      print('++++++++++++++++++');
      emit(GetReqDoneState());
    } on DioException catch (e) {
      print(e.response);
      loading = false;
      emit(GetReqFailedState());
    }
  }

  List<String> specificationValueIds = [];
  setValue(String newVal) {
    specificationValueIds = GenerateSellPage.x.values.toList();
    print(specificationValueIds);
    SellDetails.setValue(specificationValueIds);
  }

  addtoSell(String val, Map x, String id) {
    setValue(val);
    if (requiredItems.contains(id)) {
      requiredItems.removeWhere((element) => element == id);
    }
    emit(RefreshState());
  }

  removeImage(int indexImage) {
    images.removeAt(indexImage);
    SellDetails.removeImage(indexImage);
    emit(RemoveState());
  }
}
