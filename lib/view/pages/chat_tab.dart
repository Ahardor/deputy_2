import 'package:deputy_2/logic/home_m.dart';
import 'package:deputy_2/parameters.dart';
import 'package:deputy_2/view/elements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageManager, HomePageState>(
      listener: (context, state) {},
      child: SafeArea(
        child: Column(
          children: [
            for (var i in context.watch<HomePageManager>().state.chats)
              ChatCard(chat: i),
          ],
        ),
      ),
    );
  }
}
