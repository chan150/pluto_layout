part of pluto_layout_tabs;

class _ItemsNotifier extends Notifier<List<PlutoLayoutTabItem>> {
  final List<PlutoLayoutTabItem> initialValue;
  _ItemsNotifier(this.initialValue);

  @override
  List<PlutoLayoutTabItem> build() => initialValue;

  PlutoLayoutTabItem? findById(Object id) {
    return state.firstWhereOrNull((e) => e.id == id);
  }

  int indexById(Object id) {
    return state.indexWhere((e) => e.id == id);
  }

  void setEnabled(
    Object id,
    bool flag,
    PlutoLayoutTabMode mode, {
    bool? forceShowOne,
  }) {
    PlutoLayoutTabItem disableOrNot(PlutoLayoutTabItem item) {
      if (mode.isShowOneMode || forceShowOne == true) {
        return item.copyWith(enabled: false);
      } else {
        return item;
      }
    }

    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(enabled: flag) else disableOrNot(item),
    ];
  }

  void toggleAll(bool flag, PlutoLayoutTabMode mode) {
    if (mode.isShowOneMust) return;

    state = [
      for (final item in state)
        if (item.enabled == flag) item else item.copyWith(enabled: flag),
    ];
  }

  void insert(int index, PlutoLayoutTabItem item) {
    if (index < 0) index = 0;

    final length = state.length;

    if (index > length) index = length;

    state.insert(index, item);
    state = [...state];
  }

  void remove(Object id) {
    state = [
      for (final e in state)
        if (id != e.id) e,
    ];
  }
}

final _itemsProvider =
    NotifierProvider<_ItemsNotifier, List<PlutoLayoutTabItem>>(() {
  return _ItemsNotifier([]);
});
