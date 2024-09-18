import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/NotificaionsSettingsCubit/notifications_cubit.dart';
import 'package:elconnected/presentation/blocs/NotificaionsSettingsCubit/notifications_state.dart';
import 'package:elconnected/presentation/widgets/notification_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NotificationsettingsScreen extends StatelessWidget {
  const NotificationsettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit(),
      child: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.notifications.tr(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                children: [
                  NotificationSettingSwitcher(
                    settingLabel: LocaleKeys.recommendations.tr(),
                    isRecommend: true,
                  ),
                  const Gap(24),
                  NotificationSettingSwitcher(
                    settingLabel: LocaleKeys.specialCommunications.tr(),
                    isRecommend: false,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
