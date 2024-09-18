import 'package:elconnected/presentation/blocs/MapCubit/map_data_cubit.dart';
import 'package:elconnected/presentation/blocs/MapCubit/map_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, this.lat, this.long});
  final double? lat, long;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapDataCubit, MapDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: MapDataCubit.get(context).buildMap(),
        );
      },
    );
  }
}
