import 'package:bot_toast/bot_toast.dart';
import 'package:deputy_2/connection/connector.dart';
import 'package:deputy_2/connection/event.dart';
import 'package:deputy_2/parameters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterState {
  RegisterState({
    this.success = false,
  });
  bool success;
}

class RegisterManager extends Cubit<RegisterState> {
  RegisterManager() : super(RegisterState()) {
    WebSocketManager.addHandler('Api_RegisterError', (_) {
      BotToast.showText(
          text: "Данные введены неверно или пользователь уже существует");
    });

    WebSocketManager.addHandler('Api_RegisterSuccess', (_) {
      BotToast.showText(text: "Регистрация прошла успешно");
      // Navigator.of(context).pop();
      emit(RegisterState(success: true));
    });
  }

  @override
  Future<void> close() {
    WebSocketManager.removeLastHandler('Api_RegisterError');
    WebSocketManager.removeLastHandler('Api_RegisterSuccess');
    return super.close();
  }

  void register({
    required String email,
    required String password,
    required String passwordConfirm,
    required String name,
    String token = "",
  }) {
    var split = name.split(' ');
    String firstName = split.isNotEmpty ? split[0] : "";
    String lastName = split.length > 1 ? split[1] : "";
    String patronymic = split.length > 2 ? split[2] : "";

    bool allow = firstName != '' &&
        lastName != '' &&
        email != '' &&
        password != '' &&
        passwordConfirm != '' &&
        password == passwordConfirm &&
        RegExp(emailRegEx).hasMatch(email);

    if (allow) {
      WebSocketManager.writeMessage(
        App_EventRegister(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          patronymic: patronymic,
          token: token,
        ),
      );
    } else {
      BotToast.showText(text: "Заполните все поля");
    }
  }
}
