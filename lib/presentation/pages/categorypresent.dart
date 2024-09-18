import 'package:elconnected/constant/appassets.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_cubit.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_state.dart';
import 'package:elconnected/presentation/widgets/categorypresent_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPresentScreen extends StatefulWidget {
  const CategoryPresentScreen(
      {super.key, required this.id, required this.name});

  final String name, id;

  @override
  State<CategoryPresentScreen> createState() => _CategoryPresentScreenState();
}

class _CategoryPresentScreenState extends State<CategoryPresentScreen> {
  @override
  void initState() {
    scControll.addListener(scrollListener);
    SubCatergoriesCubit.get(context).getCategoryData(widget.id, false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, // status bar color
    ));
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controller to avoid memory leaks
    scControll.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // status bar color
    ));
    super.dispose();
  }

  void scrollListener() {
    if (scControll.offset >= scControll.position.maxScrollExtent - 200 &&
        !scControll.position.outOfRange) {
      SubCatergoriesCubit.get(context).tempList.isEmpty
          ? SubCatergoriesCubit.get(context).scroll(widget.id)
          : null;
    }
  }

  ScrollController scControll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCatergoriesCubit, SubCatergoriesState>(
      listener: (context, state) {
        if (state is FilterItemsDoneState) {
          print("filter");
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  height: Device.deviceHeight(
                      context: context,
                      percent: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 1 / 1.8
                          : 1),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.realStateBackground),
                          fit: BoxFit.cover)),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Device.deviceHeight(
                      context: context,
                      percent: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 1 / 1.7
                          : 1 / 3.2),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(120))),
                ),
              ),
              CategoryPresentList(
                name: widget.name,
                controller: scControll,
                id: widget.id,
              )
            ],
          ),
        );
      },
    );
  }
}
