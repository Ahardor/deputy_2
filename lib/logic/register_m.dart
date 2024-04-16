import 'package:bot_toast/bot_toast.dart';
import 'package:deputy_2/connection/connector.dart';
import 'package:deputy_2/connection/event.dart';
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
    required String firstName,
    required String lastName,
    String patronymic = "",
    String token = "",
  }) {
    bool allow = firstName != '' &&
        lastName != '' &&
        patronymic != '' &&
        email != '' &&
        password != '' &&
        passwordConfirm != '' &&
        password == passwordConfirm;

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
