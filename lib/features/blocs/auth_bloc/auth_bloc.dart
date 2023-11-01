import 'package:bloc/bloc.dart';
import 'package:learn_bloc_http/features/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc(this.userRepository) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnAuthenticated());
      }
    });

    on<LoggedIn>(
      (event, emit) async {
        emit(AuthLoading());
        await userRepository.saveToken(event.token);
        emit(AuthAuthenticated());
      },
    );
    on<LoggedOut>((event, emit) async {
      emit(AuthLoading());
      await userRepository.deleteToken();
      emit(AuthUnAuthenticated());
    });
  }
}
