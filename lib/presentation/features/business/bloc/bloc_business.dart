import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/business/business.dart';
import 'bloc_business_event.dart';
import 'bloc_business_state.dart';

class BlocBusiness extends Bloc<BlocBusinessEvent, BlocBusinessState> {
  BlocBusiness(BlocBusinessState initialState) : super(initialState) {
    on<RefreshBusiness>((event, emit) => emit(BlocBusinessState(event.getBusiness())));
  }

  void refreshBusiness(Business business) => add(RefreshBusiness(business));
}
