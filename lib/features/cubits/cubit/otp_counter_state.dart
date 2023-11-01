part of 'otp_counter_cubit.dart';

@immutable
abstract class OtpTimerState extends Equatable {
  final int duration;
  const OtpTimerState({
    required this.duration,
  });
  @override
  List<Object?> get props => [duration];

  @override
  String toString() => 'OtpTimerState(duration: $duration)';
}

class OtpTimerInitial extends OtpTimerState {
  const OtpTimerInitial({required super.duration});

  @override
  List<Object?> get props => [duration];
  @override
  String toString() => 'OtpTimerInitial(duration: $duration)';
}

class OtpTimerContinue extends OtpTimerState {
  const OtpTimerContinue({required super.duration});

  @override
  List<Object?> get props => [duration];
  @override
  String toString() => 'OtpTimerContinue(duration: $duration)';
}

class OtpTimerCompleted extends OtpTimerState {
  const OtpTimerCompleted() : super(duration: 0);
}
