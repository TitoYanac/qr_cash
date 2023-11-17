class MyBottonNavigationBarEvent {
  final DateTime timestamp;

  MyBottonNavigationBarEvent({DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

class ToPage extends MyBottonNavigationBarEvent {
  int index;
  ToPage(this.index);

  int getIndex() => index;
}
