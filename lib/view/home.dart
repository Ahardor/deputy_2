import 'package:deputy_2/logic/home_m.dart';
import 'package:deputy_2/view/pages/chat_tab.dart';
import 'package:deputy_2/view/pages/task_tab.dart';
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
      child: const DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.task_alt_outlined),
              ),
              Tab(
                icon: Icon(Icons.message_outlined),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              TaskTab(),
              ChatTab(),
            ],
          ),
        ),
      ),
    );
  }
}
