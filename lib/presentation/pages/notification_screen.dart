import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_routs.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/models/notifications_model.dart';
import 'package:elconnected/presentation/blocs/DisplayItemCubit/dispaly_item_cubit.dart';
import 'package:elconnected/presentation/blocs/NotificationCubit/notifications_data_cubit.dart';
import 'package:elconnected/presentation/blocs/NotificationCubit/notifications_data_state.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_cubit.dart';
import 'package:elconnected/presentation/pages/categorypresent.dart';
import 'package:elconnected/presentation/pages/itemdetailes_screen.dart';
import 'package:elconnected/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsDataCubit, NotificationsDataState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            title: Text(
              LocaleKeys.notifications.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            centerTitle: true,
          ),
          body: NotificationsDataCubit.get(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppThemeData.appBlue,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    List<NotificationItems> theList =
                        NotificationsDataCubit.get(context).notificationList;
                    return Container(
                      width: Device.deviceWidth(context: context),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () => NotificationActions.tapAction(
                          action: theList[index].navigationType ?? "",
                          context: context,
                          id: theList[index].navigationReferenceId ?? "",
                        ),
                        child: NotificationItem(
                          title: theList[index].title ?? "",
                          message: theList[index].message ?? "",
                          timeAgo: theList[index].timeAgo ?? "",
                          image: theList[index].imageUrl ?? "",
                        ),
                      ),
                    );
                  },
                  itemCount: NotificationsDataCubit.get(context)
                      .notificationList
                      .length,
                ),
        );
      },
    );
  }
}

class NotificationActions {
  static tapAction(
      {required String action,
      required BuildContext context,
      required String id}) {
    switch (action) {
      case "OutsideUrl":
        launchUrl(Uri.parse(id));
        break;
      case "Item":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider(
                      create: (context) => DispalyItemCubit(),
                      child: ItemDetailesScreen(
                        id: int.parse(id),
                      ),
                    )));
        break;
      case "Category":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider(
                      create: (context) => SubCatergoriesCubit(),
                      child: CategoryPresentScreen(
                        id: id,
                        name: 'Category',
                      ),
                    )));
        break;
      case "Home":
        Navigator.pop(context);
        break;
      default:
        () {};
    }
  }
}
