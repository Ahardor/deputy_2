import 'package:deputy_2/parameters.dart';
import 'package:flutter/material.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Секретарь',
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
              color: AppColors.mainColor,
              shadows: const [
                Shadow(
                  color: Colors.grey,
                  offset: Offset(0, 2),
                  blurRadius: 1,
                )
              ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.mainColor),
                decoration: logInField(hint: "Почта"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.mainColor),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 20)),
                ),
                child: const Text(
                  "Восстановить",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
