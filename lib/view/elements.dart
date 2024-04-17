import 'package:deputy_2/connection/types.dart';
import 'package:deputy_2/parameters.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    // print(chat);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.backColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/chat', arguments: chat.id);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.mainColor,
                    radius: 30,
                    child: Icon(
                      Icons.person_2_outlined,
                      color: AppColors.backColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    chat.name,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.sender == currentUser.id
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: message.sender == currentUser.id
              ? AppColors.mainColor
              : AppColors.accentColor,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Padding(
              padding: message.text.length > 50 || message.text.contains('\n')
                  ? const EdgeInsets.only(bottom: 20)
                  : EdgeInsets.only(
                      right: message.sender == currentUser.id ? 60 : 40),
              child: Text(
                message.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                // textAlign: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formatTime(message.date!),
                  style: TextStyle(
                    color: AppColors.backColor.shade500,
                    fontSize: 12,
                  ),
                ),
                ...(message.sender == currentUser.id
                    ? [
                        const SizedBox(width: 2),
                        Icon(
                          message.status == "Unread"
                              ? Icons.check
                              : Icons.check_circle_outline,
                          size: 15,
                          color: AppColors.backColor.shade500,
                        ),
                      ]
                    : [])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
