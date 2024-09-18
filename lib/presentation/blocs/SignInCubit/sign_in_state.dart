abstract class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoadingState extends SignInState {}

final class SignInDoneState extends SignInState {}

final class SignInFailedState extends SignInState {}

final class GetProfileLoadingState extends SignInState {}

final class GetProfileDoneState extends SignInState {}

final class GetProfileFailedState extends SignInState {}
