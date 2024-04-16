library connector;

import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:deputy_2/connection/event.dart';
import 'package:flutter/material.dart';

class WebSocketManager {
  static WebSocket? ws;

  static final Map<String, List<Function(Event)>> _handlers = {};

  static addHandler(String event, Function(Event) handler) {
    if (_handlers.containsKey(event)) {
      _handlers[event]!.add(handler);
    } else {
      _handlers[event] = [handler];
    }
  }

  static removeHandler(String event, Function handler) {
    if (_handlers.containsKey(event)) {
      _handlers[event]!.remove(handler);
    }
  }

  static removeLastHandler(String event) {
    if (_handlers.containsKey(event) && _handlers[event]!.isNotEmpty) {
      _handlers[event]!.removeLast();
    }
  }

  static removeAllHandlers(String event) {
    if (_handlers.containsKey(event)) {
      _handlers[event]!.clear();
    }
  }

  static Future init() async {
    ws = await WebSocket.connect("wss://localhost:3000/ws",
        headers: {"Origin": "allowed"});
    if (ws == null) {
      debugPrint("Error while connecting to server");
    } else {
      debugPrint("Successfully connected to server");
      BotToast.showText(text: "Соединение с сервером установлено");
    }

    ws?.done.then((value) {
      BotToast.showText(
          text: "Потеряно соединение с сервером, идёт восстановление");
      WebSocketManager.init();
    });

    ws?.listen(readMessages);
  }

  static void readMessages(data) {
    Event event = Event.parse(data);

    if (_handlers.containsKey(event.type) &&
        _handlers[event.type]!.isNotEmpty) {
      for (var handler in _handlers[event.type]!) {
        handler(event);
      }
    } else {
      debugPrint("Unhandled event type: ${event.type}");
    }
  }

  static void writeMessage(Event event) {
    debugPrint(event.toString());
    ws?.add(event.toJson());
  }
}
