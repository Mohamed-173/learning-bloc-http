import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_bloc_http/features/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'check_event.dart';
part 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  UserRepository userRepository;
  CheckBloc(
    this.userRepository,
  ) : super(CheckInitial()) {
    on<CheckEmailExistEvent>(_checkEmailExistEvent);
    on<CheckUserExistEvent>(
      _checkUserExistEvent,
    );
  }

  void _checkUserExistEvent(CheckUserExistEvent event, emit) async {
    emit(CheckLoading());
    try {
      final result =
          await userRepository.checkRegistered3(phoneNo: event.phoneNo);
      //! i am working here please be paitent

      log("we are working at check");

      log(result.toString());

      // emit(CheckSuccessfully(
      //   message: result.toString(),
      // ));
    } catch (e) {
      if (e is DioException) {
        var erMessage = e.response?.data["success"];
        if (erMessage != null) {
          emit(CheckFailed(error: erMessage.toString()));
        } else {
          emit(CheckFailed(error: e.response.toString()));
        }
      } else {
        // if the problem with internet or not dioexception
        emit(
          CheckFailed(error: e.toString()),
        );
      }
    }
  }

  void _checkEmailExistEvent(CheckEmailExistEvent event, emit) async {
    emit(CheckLoading());
    try {
      // final result = await userRepository.checkEmail(event.email);
      // final result = await userRepository.login(event.email, "cityslicka");
      final result = await userRepository.checkEmail(event.email);
      log(result.toString());
      if (result != null || result != '') {
        emit(CheckSuccessfully());
      } else {
        emit(CheckFailed(error: result.toString()));
      }
    } catch (e) {
      if (e is DioException) {
        // log(e.response!.data["error"]);
        var erMessage = e.response!.data["error"];
        if (erMessage != null) {
          // log(e.response!.data["message"]);
          log(erMessage);

          emit(CheckFailed(error: erMessage));
        } else {
          emit(CheckFailed(error: e.response.toString()));
        }
      }

      // if (e is DioException) {

      // }
      // emit(CheckFailed(error: e.toString()));
    }
  }
}
