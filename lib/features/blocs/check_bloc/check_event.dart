part of 'check_bloc.dart';

@immutable
abstract class CheckEvent extends Equatable {}

// this eventfor future for email check
class CheckEmailExistEvent extends CheckEvent {
  final String email;

  CheckEmailExistEvent(this.email);
  @override
  List<Object> get props => [email];
}

//this event for check user is already registered or not(:)
class CheckUserExistEvent extends CheckEvent {
  final String phoneNo;

  CheckUserExistEvent(this.phoneNo);
  @override
  List<Object> get props => [phoneNo];
}
