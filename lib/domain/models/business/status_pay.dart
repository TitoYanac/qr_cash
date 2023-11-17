
import '../../../data/entities/status_pay_entity.dart';

class StatusPay {
  String id;
  String available;
  String redeem;
  String date;
  String balance;
  String status;
  String notified;

  StatusPay({
    required this.id,
    required this.available,
    required this.redeem,
    required this.date,
    required this.balance,
    required this.status,
    required this.notified,
  });

  StatusPayEntity toStatusPayEntity() {
    return StatusPayEntity(
      id: id,
      available: available,
      redeem: redeem,
      date: date,
      balance: balance,
      status: status,
      notified: notified,
    );
  }
}