import 'dart:async';
import 'package:elconnected/presentation/blocs/MapCubit/map_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDataCubit extends Cubit<MapDataState> {
  MapDataCubit() : super(MapDataInitial());
  static MapDataCubit get(context) => BlocProvider.of(context);
  double? latitude;
  double? longitude;
  Completer<GoogleMapController> _mapController = Completer();

  Widget buildMap({
    double? lat,
    double? long,
  }) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      zoomGesturesEnabled: true,
      markers: Set<Marker>.of([
        Marker(
            markerId: MarkerId("1"),
            position: LatLng(
                lat ?? latitude ?? 30.033333, long ?? longitude ?? 31.233334))
      ]),
      onTap: (argument) {
        print(argument.longitude);
        latitude = argument.latitude;
        longitude = argument.longitude;
        emit(BuildMapState());
      },
      initialCameraPosition: CameraPosition(
        bearing: 0.0,
        target: LatLng(lat ?? 30.033333, long ?? 31.233334),
        tilt: 0.0,
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }
}
