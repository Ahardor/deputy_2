import 'package:deputy_2/connector.dart';
import 'package:deputy_2/parameters.dart';
import 'package:deputy_2/register/register_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _patronymicCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confPassCtrl = TextEditingController();

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
    return BlocListener<RegisterManager, RegisterState>(
      listener: (context, state) {
        if (state.success) {
          Navigator.of(context).pop();
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
              const SizedBox(width: double.infinity),
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: _firstNameCtrl,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mainColor),
                  decoration: logInField(hint: "Имя"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: _lastNameCtrl,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mainColor),
                  decoration: logInField(hint: "Фамилия"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: _patronymicCtrl,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mainColor),
                  decoration: logInField(hint: "Отчество"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: _confPassCtrl,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mainColor),
                  decoration: logInField(hint: "Подтверждение пароля"),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => context.read<RegisterManager>().register(
                        email: _emailCtrl.text,
                        password: _passCtrl.text,
                        passwordConfirm: _confPassCtrl.text,
                        firstName: _firstNameCtrl.text,
                        lastName: _lastNameCtrl.text,
                        patronymic: _patronymicCtrl.text,
                      ),
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
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
