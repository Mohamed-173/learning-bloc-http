import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_bloc_http/features/blocs/auth_bloc/auth_bloc.dart';
import 'package:learn_bloc_http/features/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository;
  AuthBloc authBloc;
  RegisterBloc(
    this.userRepository,
    this.authBloc,
  ) : super(RegisterInitial()) {
    on<OnButtonPressedEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        final token = await userRepository.register(
          name: event.name,
          phonNo: event.phoneNo,
          email: event.email,
          password: event.password,
          rePassword: event.rePassword,
        );
        log(token);
        authBloc.add(LoggedIn(token: token));
        emit(RegisterInitial());
      } catch (e) {
        if (e is DioException) {
          if (e.response!.data != null) {
            emit(RegisterFailed(e.response!.data.toString()));
          } else {
            emit(RegisterFailed(e.response.toString()));
          }
        } else {
          emit(RegisterFailed(e.toString()));
        }
      }
    });
  }
}
