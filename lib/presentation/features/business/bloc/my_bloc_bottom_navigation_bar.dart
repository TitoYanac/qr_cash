import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_bottom_navigation_bar_event.dart';
import 'bloc_bottom_navigation_bar_state.dart';

class MyBlocBottomNavigationBar extends Bloc<MyBottonNavigationBarEvent, MyBottomNavigationBarState> {
  MyBlocBottomNavigationBar(MyBottomNavigationBarState initialState) : super(initialState) {
    on<ToPage>((event, emit) => emit(MyBottomNavigationBarState(event.getIndex())));
  }

  void toPage(int index) => add(ToPage(index));
}
