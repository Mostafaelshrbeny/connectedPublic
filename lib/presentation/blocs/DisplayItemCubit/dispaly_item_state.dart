abstract class DispalyItemState {}

final class DispalyItemInitial extends DispalyItemState {}

final class ViewItemDone extends DispalyItemState {}

final class ViewItemFailed extends DispalyItemState {}

final class LoveThisItem extends DispalyItemState {}

final class LoveThisItemDone extends DispalyItemState {}

final class LoveThisItemFailed extends DispalyItemState {}

final class ShareItemDone extends DispalyItemState {}

final class ShareItemFailed extends DispalyItemState {}

final class GetItemDataFailed extends DispalyItemState {}

final class GetItemDataLoading extends DispalyItemState {}

final class GetItemDataDone extends DispalyItemState {}
