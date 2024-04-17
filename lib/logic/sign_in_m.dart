import 'package:bot_toast/bot_toast.dart';
import 'package:deputy_2/connection/connector.dart';
import 'package:deputy_2/connection/event.dart';
import 'package:deputy_2/connection/types.dart';
import 'package:deputy_2/parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInState {
  SignInState({
    this.success = false,
    this.rememberMe = false,
  });
  bool success;
  bool rememberMe;
}

class SignInManager extends Cubit<SignInState> {
  SignInManager() : super(SignInState()) {
    WebSocketManager.addHandler('Api_LogInError', (_) {
      BotToast.showText(text: "Неправильная почта или пароль");
    });

    WebSocketManager.addHandler('Api_LogInSuccess', (event) {
      BotToast.showText(text: "Вход выполнен успешно");

      debugPrint('${event.data}');
      currentUser = User.parse(data: event.data!);

      emit(SignInState(success: true));
    });

    WebSocketManager.addHandler("onConnected", (p0) {
      if (settings.getBool("rememberMe") ?? false) {
        WebSocketManager.writeMessage(App_EventLogIn(
          email: settings.getString("email")!,
          password: settings.getString("password")!,
        ));
      }
    });
  }

  @override
  Future<void> close() {
    WebSocketManager.removeLastHandler('Api_LogInError');
    WebSocketManager.removeLastHandler('Api_LogInSuccess');
    WebSocketManager.removeLastHandler("onConnected");
    return super.close();
  }

  void signIn(String email, String password) {
    bool allow =
        email != '' && password != '' && RegExp(emailRegEx).hasMatch(email);

    if (allow) {
      if (state.rememberMe) {
        settings.setBool("rememberMe", true);
        settings.setString("email", email);
        settings.setString("password", password);
      } else {
        settings.setBool("rememberMe", false);
        settings.setString("email", "");
        settings.setString("password", "");
      }

      WebSocketManager.writeMessage(
          App_EventLogIn(email: email, password: password));
    } else {
      BotToast.showText(text: "Заполните все поля");
    }
  }

  void rememberMe(bool rememberMe) {
    emit(SignInState(rememberMe: rememberMe));
  }
}
