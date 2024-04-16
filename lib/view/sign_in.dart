import 'package:bot_toast/bot_toast.dart';
import 'package:deputy_2/connection/connector.dart';
import 'package:deputy_2/parameters.dart';
import 'package:deputy_2/logic/sign_in_m.dart';
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
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: TextField(
                        controller: _emailCtrl,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: AppColors.mainColor),
                        decoration: logInField(
                            hint: "Почта", icon: Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: TextField(
                        controller: _passCtrl,
                        style: TextStyle(color: AppColors.mainColor),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: logInField(
                            hint: "Пароль", icon: Icons.lock_outline),
                        obscureText: true,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/forgot'),
                      child: Text("Забыли пароль?"),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () => context
                              .read<SignInManager>()
                              .signIn(_emailCtrl.text, _passCtrl.text),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.mainColor),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 15)),
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: "Войти",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: AppColors.backColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  text: "Нет аккаунта? ",
                  style: TextStyle(fontSize: 16),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/register'),
                        child: const Text(
                          "Регистрация",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
