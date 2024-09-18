import 'package:elconnected/data/data_sources/localedate.dart';

import 'package:elconnected/data/models/profile_model.dart';

class SaveToken {
  static String? fcmToken;
  static saveUser(String token) async {
    // await HiveLocaleData.myAppBox!.delete("token");
    // await HiveLocaleData.myAppBox!.put("token", token);
    await LocalePref.prefs!.setString("token", token);
  }

  static refreshToken(String refreshToken) {
    HiveLocaleData.myAppBox!.put("newtoken", refreshToken);
  }

  static setFCMtoken(String? fcm) {
    fcmToken = fcm;
  }
}

class SaveUserData {
  static savedata(ProfileModel? userdata) {
    LocalePref.prefs!.setString(
        "pic", userdata?.result?.userProfile?.profilePictureUrl ?? "");
    LocalePref.prefs!
        .setString("name", userdata?.result?.userProfile?.firstName ?? "");
    HiveLocaleData.myAppBox!
        .put("lastname", userdata?.result?.userProfile?.lastName ?? "");
    HiveLocaleData.myAppBox!.put("wishnum",
        userdata?.result?.userProfile?.stats?.totalWishlistItems ?? "");
    HiveLocaleData.myAppBox!.put("totalnum",
        userdata?.result?.userProfile?.stats?.totalItemsCounter ?? "");
    HiveLocaleData.myAppBox!.put("pend",
        userdata?.result?.userProfile?.stats?.pendingItemsCounter ?? "");
  }
}
