import 'package:deputy_2/connector.dart';
import 'package:deputy_2/parameters.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

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
            TextField(
              controller: _emailCtrl,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mainColor),
              decoration: logInField(hint: "Почта"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passCtrl,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mainColor),
              decoration: logInField(hint: "Пароль"),
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  bool allow = _emailCtrl.text != '' && _passCtrl.text != '';

                  if (allow) {
                    // Navigator.of(context).pushNamed('/home');

                    WebSocketManager.writeMessage("App_LogIn", {
                      "email": _emailCtrl.text,
                      "password": _passCtrl.text,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Заполните все поля"),
                    ));
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.mainColor),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 20)),
                ),
                child: const Text(
                  "Войти",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed('/forgot'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.mainColor),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 20)),
                    ),
                    child: const Text(
                      "Забыли пароль",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/register'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.mainColor),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 20)),
                    ),
                    child: const Text(
                      "Регистрация",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
