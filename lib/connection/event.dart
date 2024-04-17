// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:deputy_2/connection/types.dart';
import 'package:deputy_2/parameters.dart';

class Event {
  String type = "";
  Map<String, dynamic>? data = {};

  Event({
    this.type = "",
    this.data = const {},
  });

  Event.parse(String data) {
    var dataJson = jsonDecode(data);
    type = dataJson["type"];
    this.data = dataJson["data"];
  }

  @override
  String toString() {
    return 'Event{type: $type, data: $data}';
  }

  String toJson() {
    return jsonEncode({
      "type": type,
      "data": data,
    });
  }
}

class App_EventLogIn extends Event {
  String email = "";
  String password = "";

  App_EventLogIn({
    this.email = "",
    this.password = "",
  }) {
    type = "App_LogIn";
    data = {
      "email": email,
      "password": sha256.convert(password.codeUnits).toString(),
    };
  }
}

class App_EventRegister extends Event {
  String email;
  String password;
  String firstName;
  String lastName;
  String patronymic;
  String token;

  App_EventRegister({
    this.email = "",
    this.password = "",
    this.firstName = "",
    this.lastName = "",
    this.patronymic = "",
    this.token = "",
  }) {
    type = 'App_Register';
    data = {
      "firstName": firstName,
      "lastName": lastName,
      "patronymic": patronymic,
      "email": email,
      "password": sha256.convert(password.codeUnits).toString(),
      "token": token,
    };
  }
}

class App_EventGetChat extends Event {
  String chat;

  App_EventGetChat({
    required this.chat,
  }) {
    type = 'App_GetChat';
    data = {
      "chatID": chat,
    };
  }
}

class App_EventGetChats extends Event {
  List<String> chats;

  App_EventGetChats({
    required this.chats,
  }) {
    type = 'App_GetChats';
    data = {
      "chatIDs": chats,
    };
  }
}

class App_EventSendMessage extends Event {
  Message msg;

  App_EventSendMessage({
    required this.msg,
  }) {
    type = 'App_SendMessage';
    data = {
      "chatID": msg.chatID,
      "text": msg.text,
      "senderID": msg.sender,
      "date": formatDateTime(msg.date!),
    };
  }
}
