import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';

part 'otp_counter_state.dart';

class OtpCounterCubit extends Cubit<OtpTimerState> {
  final Ticker _ticker;
  static const int duration = 120;
  StreamSubscription<int>? _tickerSubscription;
  OtpCounterCubit({required Ticker tiker})
      : _ticker = tiker,
        super(const OtpTimerInitial(duration: duration));

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
