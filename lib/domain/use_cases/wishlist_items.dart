class ItemActions {
  static List<int> likedItems = [];
 static addItem(int id) {
    if (likedItems.contains(id)) {
      likedItems.removeWhere((element) => element == id);
    } else {
      likedItems.add(id);
    }
  }
}
