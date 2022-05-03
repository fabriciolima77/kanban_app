import 'package:flutter/material.dart';

class FazerTab extends StatefulWidget {
  const FazerTab({Key? key}) : super(key: key);

  @override
  State<FazerTab> createState() => _FazerTabState();
}

class _FazerTabState extends State<FazerTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.plus_one),
        backgroundColor: const Color(0xFF0DDB7B),
      ),
    );
  }
}
