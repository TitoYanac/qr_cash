import '../../../../domain/models/business/business.dart';

class BlocBusinessEvent {
  final DateTime timestamp;

  BlocBusinessEvent({DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

class RefreshBusiness extends BlocBusinessEvent {
  Business business;
  RefreshBusiness(this.business);

  Business getBusiness() => business;
}
