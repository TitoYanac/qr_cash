
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/user/user.dart';
import 'bloc_user_event.dart';
import 'bloc_user_state.dart';

class BlocUser extends Bloc<BlocUserEvent, BlocUserState> {
  BlocUser(BlocUserState initialState) : super(initialState) {
    on<RefreshUser>((event, emit) => emit(BlocUserState(event.getUser())));
  }

  void refreshUser(User user) => add(RefreshUser(user));
}
