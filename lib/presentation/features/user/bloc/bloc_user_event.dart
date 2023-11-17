
import '../../../../domain/models/user/user.dart';

class BlocUserEvent {
  final DateTime timestamp;

  BlocUserEvent({DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

class RefreshUser extends BlocUserEvent {
  User user;
  RefreshUser(this.user);

  User getUser() => user;
}
