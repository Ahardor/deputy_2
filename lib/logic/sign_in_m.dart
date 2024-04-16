import 'package:bot_toast/bot_toast.dart';
import 'package:deputy_2/connection/connector.dart';
import 'package:deputy_2/connection/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInState {
  SignInState({
    this.success = false,
  });
  bool success;
}

class SignInManager extends Cubit<SignInState> {
  SignInManager() : super(SignInState()) {
    WebSocketManager.addHandler('Api_LogInError', (_) {
      BotToast.showText(text: "Неправильная почта или пароль");
    });

    WebSocketManager.addHandler('Api_LogInSuccess', (event) {
      BotToast.showText(text: "Вход выполнен успешно");
      debugPrint('${event.data}');
      emit(SignInState(success: true));
    });
  }

  @override
  Future<void> close() {
    WebSocketManager.removeLastHandler('Api_LogInError');
    WebSocketManager.removeLastHandler('Api_LogInSuccess');
    return super.close();
  }

  void signIn(String email, String password) {
    bool allow = email != '' && password != '';

    if (allow) {
      // Navigator.of(context).pushNamed('/home');

      WebSocketManager.writeMessage(
          App_EventLogIn(email: email, password: password));
    } else {
      BotToast.showText(text: "Заполните все поля");
    }
  }
}
