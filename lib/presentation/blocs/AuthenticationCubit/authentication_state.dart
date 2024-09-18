abstract class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class ShowPasswordState extends AuthenticationState {}

final class ChangeActionState extends AuthenticationState {}
