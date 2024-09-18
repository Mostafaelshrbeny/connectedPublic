abstract class AccountPrivacyState {}

final class AccountPrivacyInitial extends AccountPrivacyState {}

final class ChangingPasswordState extends AccountPrivacyState {}

final class PasswordVisibilityState extends AccountPrivacyState {}
