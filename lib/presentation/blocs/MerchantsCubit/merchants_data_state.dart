abstract class MerchantsDataState {}

final class MerchantsDataInitial extends MerchantsDataState {}

final class MerchantScrollState extends MerchantsDataState {}

final class GetMerchantDoneState extends MerchantsDataState {}

final class GetMerchantLoadingState extends MerchantsDataState {}

final class GetMerchantFailedState extends MerchantsDataState {}
