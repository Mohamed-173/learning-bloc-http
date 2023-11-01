part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  // final String email;
  // final String password;
  final String? phonNo;
  const LoginButtonPressed({required this.phonNo});
  @override
  List<Object?> get props => [phonNo];

  @override
  String toString() => 'LoggedButtonPressed($phonNo)';
}
