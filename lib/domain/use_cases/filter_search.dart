class FilterSearch {
  static List<String> filters = [];
  static clearFilter() {
    filters.clear();
  }

  static addFilter(String filter) {
    if (filters.contains(filter)) {
      filters.remove(filter);
    } else {
      filters.add(filter);
    }
  }
}
