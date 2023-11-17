import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_btn_event.dart';
import 'bloc_btn_state.dart';

class MyBlocBtn extends Bloc<MyBtnEvent, MyStateBtn> {
  MyBlocBtn(MyStateBtn initialState) : super(initialState) {
    on<FetchData>((_, emit)=> emit(const MyStateBtn(statusButton: 1)));
    on<CancelFetch>((_, emit) => emit(const MyStateBtn(statusButton: 0)));
  }

  void fetchData() => add(FetchData());

  void cancelFetch() => add(CancelFetch());
}
