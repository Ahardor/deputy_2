import 'package:deputy_2/connection/connector.dart';
import 'package:deputy_2/connection/event.dart';
import 'package:deputy_2/connection/types.dart';
import 'package:deputy_2/parameters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageState {
  ChatPageState({
    this.chat,
  });
  Chat? chat;
}

class ChatPageManager extends Cubit<ChatPageState> {
  ChatPageManager() : super(ChatPageState()) {
    WebSocketManager.addHandler(
      "Api_NewMessage",
      (event) {
        if (event.data!["ChatID"] == state.chat!.id) {
          state.chat!.messages.add(Message.parse(data: event.data!));
          emit(ChatPageState(chat: state.chat));
        }
      },
    );

    WebSocketManager.addHandler(
      "Api_GetChatSuccess",
      (event) {
        state.chat = Chat.parse(data: event.data!);
        allChats[state.chat!.id] = state.chat!;
        emit(ChatPageState(chat: state.chat));
      },
    );
  }

  @override
  Future<void> close() {
    WebSocketManager.removeLastHandler("Api_NewMessage");
    WebSocketManager.removeLastHandler("Api_GetChatSuccess");
    return super.close();
  }

  void init(String chatId) {
    WebSocketManager.writeMessage(App_EventGetChat(chat: chatId));
    emit(ChatPageState(chat: allChats[chatId]!));
  }

  void send(String text) {
    if (text != "") {
      var msg = Message(
        text: text,
        sender: currentUser.id,
        date: DateTime.now().toUtc().add(const Duration(hours: 3)),
        chatID: state.chat!.id,
        status: "Unread",
      );

      WebSocketManager.writeMessage(App_EventSendMessage(msg: msg));

      // state.chat!.messages.add(msg);

      // emit(ChatPageState(chat: state.chat));
    }
  }
}
