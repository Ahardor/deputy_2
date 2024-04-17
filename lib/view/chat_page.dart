import 'package:deputy_2/connection/types.dart';
import 'package:deputy_2/logic/chat_m.dart';
import 'package:deputy_2/parameters.dart';
import 'package:deputy_2/view/elements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String chatId = "";
  bool once = false;
  var messageController = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
  }

  @override
  void didChangeDependencies() {
    if (!once) {
      once = true;
      chatId = ModalRoute.of(context)!.settings.arguments as String;
      context.read<ChatPageManager>().init(chatId);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatPageManager, ChatPageState>(
      listener: (context, state) {
        _controller.animateTo(
          _controller.position.maxScrollExtent + 70,
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
        );
        messageController.clear();
      },
      child: Scaffold(
        backgroundColor: AppColors.back2Color,
        appBar: AppBar(
          title: Text(context.watch<ChatPageManager>().state.chat!.name),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  for (var i
                      in context.watch<ChatPageManager>().state.chat!.messages)
                    MessageCard(message: i),
                  const SizedBox(
                    width: double.infinity,
                    height: 70,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          constraints: const BoxConstraints(
                              minHeight: 50, maxHeight: 200),
                          child: TextField(
                            onTap: () => Future.delayed(
                              const Duration(milliseconds: 200),
                              () => _controller.animateTo(
                                _controller.position.maxScrollExtent + 70,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                            controller: messageController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 7,
                            decoration: InputDecoration(
                                hintText: "Напишите сообщение...",
                                fillColor: AppColors.backColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(15)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 0,
                        fit: FlexFit.tight,
                        child: Ink(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mainColor,
                          ),
                          height: 50,
                          width: 50,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              context
                                  .read<ChatPageManager>()
                                  .send(messageController.text);
                            },
                            child: Icon(
                              Icons.send,
                              color: AppColors.backColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
