part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoggedInState extends LoginState {
  final String name;
  final String email;
  final String icon;

  LoggedInState({required this.name, required this.email, required this.icon});
}

final class LoggedOutState extends LoginState {}

final class LoginErrorState extends LoginState {}
