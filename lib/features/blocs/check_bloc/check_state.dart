part of 'check_bloc.dart';

@immutable
abstract class CheckState extends Equatable {}

class CheckInitial extends CheckState {
  @override
  List<Object?> get props => [];
}

class CheckSuccessfully extends CheckState {
  final String? message;

  CheckSuccessfully({this.message});
  @override
  List<Object?> get props => [];
}

class CheckLoading extends CheckState {
  @override
  List<Object?> get props => [];
}

class CheckFailed extends CheckState {
  final String error;
  CheckFailed({
    required this.error,
  });
  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'CheckFailed(error: $error)';
}
