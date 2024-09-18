abstract class ManageAccountState {}

final class ManageAccountInitial extends ManageAccountState {}

final class SwithToDeletingState extends ManageAccountState {}

final class ShowPasswordState extends ManageAccountState {}

final class DeleteDoneState extends ManageAccountState {}

final class DeleteLoadingState extends ManageAccountState {}

final class DeleteFailedState extends ManageAccountState {}
