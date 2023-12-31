part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailed extends LoginState {
  final String error;
  const LoginFailed({
    required this.error,
  });

  @override
  String toString() => 'LoginFailed(error: $error)';

  @override
  List<Object?> get props => [error];
}
