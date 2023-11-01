import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_bloc_http/features/blocs/auth_bloc/auth_bloc.dart';
import 'package:learn_bloc_http/features/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;
  LoginBloc({required this.userRepository, required this.authBloc})
      : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final token = await userRepository.loginByPhoneNo(event.phonNo);

        authBloc.add(LoggedIn(token: token));
        emit(LoginInitial());
      } catch (e) {
        if (e is DioException) {
          log(e.response!.data["error"]);
          final erMessage = e.response!.data["error"];
          emit(LoginFailed(error: erMessage));
        }
        // emit(LoginFailed(error: e.toString()));
      }
    });
  }
}
