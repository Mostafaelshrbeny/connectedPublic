abstract class QrCodeState {}

final class QrCodeInitial extends QrCodeState {}

final class GetQrCodeDoneState extends QrCodeState {}

final class GetQrCodeLoadingState extends QrCodeState {}

final class GetQrCodeFailedState extends QrCodeState {}
