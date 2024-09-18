abstract class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class SwitchSettingsState extends NotificationsState {}

final class ChangeNotificationsDoneState extends NotificationsState {}

final class ChangeNotificationsLoadingState extends NotificationsState {}

final class ChangeNotificationsFailedState extends NotificationsState {}
