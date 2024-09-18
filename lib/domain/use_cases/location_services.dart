import 'package:elconnected/domain/use_cases/sell_details.dart';
import 'package:location/location.dart';

class LocationServices {
  static Location location = Location();

  static bool? serviceEnabled;
  static PermissionStatus? permissionGranted;
  static LocationData? locationData;

  static getloctaion() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    SellDetails.setlocationData(
        locationlat: locationData?.latitude ?? 0,
        locationlong: locationData?.longitude ?? 0);
  }
}
