
class MyBtnEvent {
  final DateTime timestamp;

  MyBtnEvent({DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

class FetchData extends MyBtnEvent {}

class CancelFetch extends MyBtnEvent {}
