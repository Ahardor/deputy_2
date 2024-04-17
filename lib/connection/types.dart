import 'package:deputy_2/parameters.dart';

class User {
  String email = "";
  String firstName = "";
  String lastName = "";
  String patronymic = "";
  String id = "";
  String token = "";
  List<String> chats = [];

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.patronymic = "",
    required this.id,
    this.token = "",
    this.chats = const [],
  });

  User.parse({
    required Map<String, dynamic> data,
  }) {
    email = data["Email"] ?? "";
    firstName = data["FirstName"] ?? "";
    lastName = data["LastName"] ?? "";
    patronymic = data["Patronymic"] ?? "";
    id = data["ID"] ?? "";
    token = data["Token"] ?? "";
    chats = [];
    for (String chat in data["Chats"]) {
      chats.add(chat);
    }
  }

  get fullName => "$lastName $firstName $patronymic";

  get name => patronymic == ""
      ? "$lastName ${firstName[0]}."
      : "$lastName ${firstName[0]}. ${patronymic[0]}.";

  @override
  String toString() {
    return 'User(email: $email, firstName: $firstName, lastName: $lastName, patronymic: $patronymic, id: $id, token: $token, chats: $chats)';
  }
}

class Message {
  String text = "";
  String sender = "";
  DateTime? date;
  String chatID = "";
  String status = "Unread";

  Message({
    required this.text,
    required this.sender,
    required this.date,
    required this.chatID,
    this.status = "Unread",
  });

  Message.parse({
    required Map<String, dynamic> data,
  }) {
    text = data["Text"] ?? "";
    sender = data["SenderID"] ?? "";
    date = DateTime.parse(data["Date"] ?? "1970-12-31T21:00:00Z");
    chatID = data["ChatID"] ?? "";
    status = data["Status"] ?? "Unread";
  }

  @override
  String toString() {
    return 'Message(text: $text, sender: $sender, date: $date, chatID: $chatID, status: $status)';
  }
}

class Chat {
  String id = "";
  String name = "";
  List<Message> messages = [];
  List<String> users = [];

  Chat({
    required this.id,
    required this.name,
    this.messages = const [],
    this.users = const [],
  });

  Chat.parse({
    required Map<String, dynamic> data,
  }) {
    id = data["ID"] ?? "";
    messages = [];
    for (var message in data["Messages"]) {
      messages.add(Message.parse(data: message));
    }
    users = [];
    for (var user in data["Users"]) {
      users.add(user);
    }
    // name = data["Name"] ?? "";
    String tempName = data["Name"] ?? "";
    name = tempName.contains('|')
        ? tempName.split('|')[0] == currentUser.name
            ? tempName.split('|')[1]
            : tempName.split('|')[0]
        : tempName;
  }

  @override
  String toString() {
    return 'Chat(id: $id, name: $name, messages: $messages, users: $users)';
  }
}
