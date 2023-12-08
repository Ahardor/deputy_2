import 'dart:io';
import 'package:deputy_2/connector.dart';
import 'package:deputy_2/forgot.dart';
import 'package:deputy_2/log_in.dart';
import 'package:deputy_2/parameters.dart';
import 'package:deputy_2/register.dart';
import 'package:flutter/material.dart';

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
  await WebSocketManager.init();
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
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LogInPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot': (context) => const ForgotPage(),
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
