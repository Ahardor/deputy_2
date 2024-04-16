import 'package:deputy_2/logic/home_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageManager, HomePageState>(
      listener: (context, state) {},
      child: Scaffold(),
    );
  }
}
