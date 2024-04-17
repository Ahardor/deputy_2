import 'package:deputy_2/logic/home_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageManager, HomePageState>(
      listener: (context, state) {},
      child: Column(),
    );
  }
}
