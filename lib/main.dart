import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:deputy_2/connector.dart';
import 'package:deputy_2/forgot.dart';
import 'package:deputy_2/home/home.dart';
import 'package:deputy_2/home/home_m.dart';
import 'package:deputy_2/register/register_m.dart';
import 'package:deputy_2/sign_in/sign_in.dart';
import 'package:deputy_2/register/register.dart';
import 'package:deputy_2/sign_in/sign_in_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  WebSocketManager.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      initialRoute: '/signIn',
      routes: {
        '/signIn': (context) => BlocProvider(
              create: (_) => SignInManager(),
              child: const SignInPage(),
            ),
        '/register': (context) => BlocProvider(
              create: (_) => RegisterManager(),
              child: const RegisterPage(),
            ),
        '/forgot': (context) => const ForgotPage(),
        '/home': (context) => BlocProvider(
              create: (_) => HomePageManager(),
              child: const HomePage(),
            )
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          toolbarHeight: 80,
        ),
        fontFamily: "Nunito",
      ),
    );
  }
}
