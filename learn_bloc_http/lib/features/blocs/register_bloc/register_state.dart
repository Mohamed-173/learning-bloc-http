part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable {}

class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterSuccessfuly extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterFailed extends RegisterState {
  final String? error;

  RegisterFailed(this.error);
  @override
  List<Object?> get props => [];
}
