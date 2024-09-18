abstract class VerificationState {}

final class VerificationInitial extends VerificationState {}

final class VerificationLoadingState extends VerificationState {}

final class VerificationDoneState extends VerificationState {}

final class VerificationFailedState extends VerificationState {}

final class ResendLoadingState extends VerificationState {}

final class ResendDoneState extends VerificationState {}

final class ResendFailedState extends VerificationState {}

final class TimerState extends VerificationState {}

final class ResendOptionState extends VerificationState {}
