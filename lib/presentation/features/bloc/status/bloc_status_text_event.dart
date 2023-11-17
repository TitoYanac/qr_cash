
abstract class StatusTextEvent {}


class ChangeStatus extends StatusTextEvent {
  final String newStatus;

  ChangeStatus(this.newStatus);
}
class ChangeStatusOnline extends StatusTextEvent {
  final bool newStatusOnline;

  ChangeStatusOnline(this.newStatusOnline);
}

class ChangeUserLogged extends StatusTextEvent {
  final bool newUserLogged;

  ChangeUserLogged(this.newUserLogged);
}
