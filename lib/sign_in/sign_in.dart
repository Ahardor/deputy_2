import 'package:bot_toast/bot_toast.dart';
import 'package:deputy_2/connector.dart';
import 'package:deputy_2/parameters.dart';
import 'package:deputy_2/sign_in/sign_in_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInManager, SignInState>(
      listener: (context, state) {
        if (state.success) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Scaffold(
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
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: _emailCtrl,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mainColor),
                  decoration: logInField(hint: "Почта"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: _passCtrl,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mainColor),
                  decoration: logInField(hint: "Пароль"),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => context
                      .read<SignInManager>()
                      .signIn(_emailCtrl.text, _passCtrl.text),
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
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/forgot'),
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
      ),
    );
  }
}
