abstract class SearchItemsState {}

final class SearchItemsInitial extends SearchItemsState {}

final class GetRecentLoadingState extends SearchItemsState {}

final class GetRecentDoneState extends SearchItemsState {}

final class GetRecentFailedState extends SearchItemsState {}

final class SearchLoadingState extends SearchItemsState {}

final class SearchDoneState extends SearchItemsState {}

final class SearchFailedState extends SearchItemsState {}

final class SearchResetState extends SearchItemsState {}
