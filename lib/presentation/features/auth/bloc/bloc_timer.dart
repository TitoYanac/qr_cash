import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;

  TimerBloc() : super(TimerState(duration: 120)) {
    on<StartTimer>(_onStartTimer);
    on<Tick>(_onTick);
    on<ResetTimer>(_onResetTimer);
  }

  void _onStartTimer(StartTimer start, Emitter<TimerState> emit) {
    if (state.duration == 0) {
      emit(TimerState(duration: 120));
    }
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(Tick(state.duration - 1));
    });
    emit(TimerState(duration: state.duration, isRunning: true));
  }

  void _onTick(Tick tick, Emitter<TimerState> emit) {
    emit(tick.duration > 0
        ? TimerState(duration: tick.duration, isRunning: true)
        : TimerState(duration: 0, isRunning: false));
  }

  void _onResetTimer(ResetTimer reset, Emitter<TimerState> emit) {
    _timer?.cancel();
    emit(TimerState(duration: 120));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
class TimerState {
  final int duration;
  final bool isRunning;

  TimerState({required this.duration, this.isRunning = false});
}
abstract class TimerEvent {}

class StartTimer extends TimerEvent {}

class Tick extends TimerEvent {
  final int duration;

  Tick(this.duration);
}

class ResetTimer extends TimerEvent {}
