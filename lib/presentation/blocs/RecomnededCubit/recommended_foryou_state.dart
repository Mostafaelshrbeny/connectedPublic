abstract class RecommendedForyouState {}

final class RecommendedForyouInitial extends RecommendedForyouState {}

final class RecommendedDoneState extends RecommendedForyouState {}

final class RecommendedLoadingState extends RecommendedForyouState {}

final class RecommendedFailedState extends RecommendedForyouState {}

final class RecommendedScrollState extends RecommendedForyouState {}

final class LikeItemDone extends RecommendedForyouState {}

final class LikeItemFailed extends RecommendedForyouState {}
