// ignore_for_file: camel_case_types

import 'dart:convert';

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
}

class Api_EventLogIn extends Event {
  String firstName = "";
  String lastName = "";
  String patronymic = "";
  int id = 0;
  String token = "";
  String role = "";

  Api_EventLogIn.parse(Event event) {
    type = event.type;
    data = event.data;
    firstName = data == null ? "" : data!["firstName"];
    lastName = data == null ? "" : data!["lastName"];
    patronymic = data == null ? "" : data!["patronymic"];
    id = data == null ? "" : data!["id"];
    token = data == null ? "" : data!["token"];
    role = data == null ? "" : data!["role"];
  }
}

class App_EventLogIn extends Event {
  String login = "";
  String password = "";

  App_EventLogIn({
    this.login = "",
    this.password = "",
  }) {
    type = "App_EventLogIn";
    data = {
      "login": login,
      "password": password,
    };
  }
}
