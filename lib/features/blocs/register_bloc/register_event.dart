part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {}

class OnButtonPressedEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String phoneNo;
  final String rePassword;

  OnButtonPressedEvent(
      {required this.name,
      required this.email,
      required this.password,
      required this.phoneNo,
      required this.rePassword});
  @override
  List<Object?> get props => [name, email, password, phoneNo, rePassword];

  @override
  String toString() {
    return 'OnPressButton(name: $name, email: $email, password: $password,rePassword: $rePassword, phoneNo: $phoneNo)';
  }
}
