import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../widgets/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 120;
  final int valideTimes = 3;
  String? name;
  String? email;
  String? password;
  String? phon;
  int startTime = 0;

  StreamSubscription<int>? _tickerSubscription;
  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(onTimerStarted);
    on<_TimerTicked>(_onTickeded);
    on<TimerReset>(onTimerReset);
  }

  void onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    startTime = 0;
    emit(const TimerInitial(_duration));
  }

  void _onTickeded(_TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : const TimerRunComplete());
  }

  void onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    if (startTime < valideTimes) {
      emit(TimerRunInProgress(event.duration));
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker.tick(ticks: event.duration).listen((event) {
        add(_TimerTicked(duration: event));
      });
      if (startTime != 0) {
        // log("we are wrong");
      } else {
        // log("we are rght");
        name = event.name;
        email = event.email;
        password = event.password;
        phon = event.phoneNo;
      }
      startTime++;
    } else {
      if (name == event.name &&
          email == event.email &&
          password == event.password &&
          phon == event.phoneNo) {
        emit(TimerRunComplete());
      } else {
        // log("the problem is here");
        startTime = 0;

        emit(TimerInitial(5));
      }
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
