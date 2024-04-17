import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:deputy_2/connection/connector.dart';
import 'package:deputy_2/logic/chat_m.dart';
import 'package:deputy_2/parameters.dart';
import 'package:deputy_2/view/chat_page.dart';
import 'package:deputy_2/view/forgot.dart';
import 'package:deputy_2/view/home.dart';
import 'package:deputy_2/logic/home_m.dart';
import 'package:deputy_2/logic/register_m.dart';
import 'package:deputy_2/view/sign_in.dart';
import 'package:deputy_2/view/register.dart';
import 'package:deputy_2/logic/sign_in_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  settings = await SharedPreferences.getInstance();

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await WebSocketManager.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorKey: navigatorKey,
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
            ),
        '/chat': (context) => BlocProvider(
              create: (_) => ChatPageManager(),
              child: const ChatPage(),
            ),
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          toolbarHeight: 80,
          foregroundColor: AppColors.secondColor,
        ),
        fontFamily: "Nunito",
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
      ),
    );
  }
}
