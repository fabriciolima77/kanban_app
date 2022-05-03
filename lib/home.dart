import 'package:flutter/material.dart';
import 'package:kanban_app/ui/fazendo_tab.dart';
import 'package:kanban_app/ui/fazer_tab.dart';
import 'package:kanban_app/ui/feito_tab.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Quadro Kanban'),
            backgroundColor: const Color(0xFF0DDB7B),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
              Tab(text: 'A Fazer', icon: Icon(Icons.new_label)),
              Tab(text: 'Fazendo', icon: Icon(Icons.pending_actions)),
              Tab(text: 'Feito', icon: Icon(Icons.done_all),),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              FazerTab(),
              FazendoTab(),
              FeitoTab(),
            ],
          ),
        ));
  }
}
