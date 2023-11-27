// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState {
  final MyUser user;
  final MyAuthStatus status;
  final String name;
  final String password;
  final String failed;
  const AuthState(
      {required this.user,
      this.failed = '',
      this.status = MyAuthStatus.initial,
      this.name = '',
      this.password = ''});

  AuthState copyWith({
    MyUser? user,
    MyAuthStatus? status,
    String? failed,
    String? name,
    String? password,
  }) {
    return AuthState(
        user: user ?? this.user,
        status: status ?? this.status,
        failed: failed ?? this.failed,
        name: name ?? this.name,
        password: password ?? this.password);
  }
}

enum MyAuthStatus { initial, success, failed }
