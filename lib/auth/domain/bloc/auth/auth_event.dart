part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AddUserEvent extends AuthEvent {
  final MyUser user;
  const AddUserEvent({required this.user});
}

class ChangeUserDataEvent extends AuthEvent {
  final MyUser user;
  const ChangeUserDataEvent({required this.user});
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String password;
  const SignUpEvent({required this.name, required this.password});
}

class SignInEvent extends AuthEvent {
  final String name;
  final String password;
  const SignInEvent({required this.name, required this.password});
}

class GetUserEvent extends AuthEvent {}

class ChangeUserImageEvent extends AuthEvent {}

class DeleteUserAccountEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}
