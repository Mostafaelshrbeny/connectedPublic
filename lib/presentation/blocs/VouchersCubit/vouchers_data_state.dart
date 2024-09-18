abstract class VouchersDataState {}

final class VouchersDataInitial extends VouchersDataState {}

final class VouchersScrollState extends VouchersDataState {}

final class GetVouchersDataDoneState extends VouchersDataState {}

final class GetVouchersDataLoadingState extends VouchersDataState {}

final class GetVouchersDataFailedState extends VouchersDataState {}

final class SellLoadingState extends VouchersDataState {}

final class SellDoneState extends VouchersDataState {}

final class SellFailedState extends VouchersDataState {}

final class SelectVoucherState extends VouchersDataState {}
