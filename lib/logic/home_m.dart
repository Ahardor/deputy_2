import 'package:deputy_2/connection/connector.dart';
import 'package:deputy_2/connection/event.dart';
import 'package:deputy_2/connection/types.dart';
import 'package:deputy_2/parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageState {
  HomePageState({this.chats = const <Chat>[]});

  var chats = <Chat>[];
}

class HomePageManager extends Cubit<HomePageState> {
  HomePageManager() : super(HomePageState()) {
    WebSocketManager.addHandler('Api_GetChatsSuccess', (event) {
      debugPrint('${event.data}');

      var chats = <Chat>[];

      for (var chatJson in event.data!["Chats"]) {
        chats.add(Chat.parse(data: chatJson));
        allChats[chatJson["ID"]] = Chat.parse(data: chatJson);
      }

      emit(HomePageState(chats: chats));
    });

    WebSocketManager.writeMessage(App_EventGetChats(chats: currentUser.chats));
  }

  @override
  Future<void> close() {
    WebSocketManager.removeLastHandler('Api_GetChatsSuccess');
    return super.close();
  }
}
