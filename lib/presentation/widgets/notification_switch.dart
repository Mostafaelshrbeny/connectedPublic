import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/NotificaionsSettingsCubit/notifications_cubit.dart';
import 'package:elconnected/presentation/blocs/NotificaionsSettingsCubit/notifications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NotificationSettingSwitcher extends StatelessWidget {
  const NotificationSettingSwitcher({
    super.key,
    required this.settingLabel,
    required this.isRecommend,
  });
  final String settingLabel;
  final bool isRecommend;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: Device.deviceWidth(context: context, percent: 1 / 1.8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(settingLabel,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const Gap(4),
                  Text(LocaleKeys.receiverecommendations.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.grey)),
                ],
              ),
            ),
            const Spacer(),
            Switch.adaptive(
              value: isRecommend
                  ? NotificationsCubit.get(context).recommedation
                  : NotificationsCubit.get(context).specialOffers,
              onChanged: (val) {
                NotificationsCubit.get(context)
                    .switchNotificationsSettings(isRecommend: isRecommend);
              },
              thumbColor: WidgetStateProperty.all(AppThemeData.appBlue),
              trackColor: WidgetStatePropertyAll(Colors.grey.withOpacity(0.3)),
            )
          ],
        );
      },
    );
  }
}
