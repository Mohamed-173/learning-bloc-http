part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {
  const TimerEvent();
}

class TimerStarted extends TimerEvent {
  const TimerStarted(
      {required this.name,
      required this.email,
      required this.password,
      required this.phoneNo,
      this.duration = 120});
  final int duration;
  final String name;
  final String email;
  final String password;
  final String phoneNo;
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class _TimerTicked extends TimerEvent {
  const _TimerTicked({required this.duration});
  final int duration;
}
