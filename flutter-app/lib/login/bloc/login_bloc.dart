import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginLoadingState()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  FutureOr<void> _onLogin(
    LoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(
      LoggedInState(
        name: 'Ferko Chmatak',
        email: 'ferko',
        icon:
            'https://icons.iconarchive.com/icons/diversity-avatars/avatars/1024/indian-man-icon.png',
      ),
    );
  }

  FutureOr<void> _onLogout(
    LogoutEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoggedOutState());
  }
}
