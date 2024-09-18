abstract class SellOperationState {}

final class SellOperationInitial extends SellOperationState {}

final class TypeSelectedState extends SellOperationState {}

final class PickedMediaState extends SellOperationState {}

final class PickedMediaLoadingState extends SellOperationState {}

final class GetReqDoneState extends SellOperationState {}

final class GetReqLoadingState extends SellOperationState {}

final class GetReqFailedState extends SellOperationState {}

final class RefreshState extends SellOperationState {}

final class RemoveState extends SellOperationState {}
