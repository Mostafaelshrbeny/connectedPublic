import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/edit_profile_model.dart';
import 'package:elconnected/data/models/profile_model.dart';
import 'package:elconnected/domain/use_cases/phone_code.dart';
import 'package:elconnected/domain/use_cases/save_token.dart';
import 'package:elconnected/domain/use_cases/upload_image.dart';
import 'package:elconnected/presentation/blocs/ProfileCubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  bool editPofile = false;
  bool loading = false;
  ProfileModel? userProfile;
  EditProfileModel? profileEdit;

  String? fName, lName;
  profileTitle() {
    return editPofile ? LocaleKeys.editProfile.tr() : LocaleKeys.profile.tr();
  }

  startEditing() {
    editPofile = !editPofile;
    emit(EditProfileState());
  }

  saveData() async {
    var data = {
      "firstName": fName ?? userProfile?.result?.userProfile?.firstName,
      "lastName": lName ?? userProfile?.result?.userProfile?.lastName
    };
    await editProfile(data);

    UploadImage.data == null ? null : await profilePicture(UploadImage.data);
    await getProfile();
    print(UploadImage.data);
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    UploadImage.reset();
    emit(EditProfileDoneState());
  }

  pickImage() async {
    await UploadImage.pickImageFromDevice();

    emit(PickedImageState());
  }

  getProfile() async {
    emit(GetProfileLoadingState());
    final dio = Dio();
    try {
      final response = await dio.get(ApiConstant.baseUrl + ApiConstant.account,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      print(response.data);
      userProfile = ProfileModel.fromJson(response.data);
      PhoneCode.setCode(
          newCode: userProfile?.result?.userProfile?.phoneCode ?? "+20",
          pNumber:
              userProfile?.result?.userProfile?.phoneNumber ?? "1234567899");
      await SaveUserData.savedata(userProfile);
      emit(GetProfileDoneState());
    } on DioException catch (e) {
      print(e.response);

      emit(GetProfileFailedState());
    }
  }

  editProfile(var data) async {
    emit(EditProfileLoadingState());
    loading = true;
    final dio = Dio();

    try {
      final response = await dio.put(ApiConstant.baseUrl + ApiConstant.account,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }),
          data: data);
      print(response.data);
      loading = false;
      emit(EditProfileDoneState());
    } on DioException catch (e) {
      print(e.response!.data);
      loading = false;
      emit(EditProfileFailedState());
    }
  }

  profilePicture(var data) async {
    emit(EditProfilePicLoadingState());
    final dio = Dio();
    try {
      final response =
          await dio.put(ApiConstant.baseUrl + ApiConstant.profilePicture,
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': LocalePref.prefs!.getString("token")
              }),
              data: data);
      print(response.data);

      emit(EditProfilePicDoneState());
    } on DioException catch (e) {
      print(e.response!.data);
      print('+++++++++++++++++++++++++++++');
      print('+++++++++++++++++++++++++++++');
      print('+++++++++++++++++++++++++++++');
      emit(EditProfilePicFailedState());
    }
  }

  changeName(bool first, String newName) {
    if (first) {
      fName = newName;
      print(fName);
    } else {
      lName = newName;
    }
  }
}
