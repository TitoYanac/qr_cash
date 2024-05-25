import 'package:flutter/material.dart';
class NotLoggedScreen extends StatefulWidget {
  const NotLoggedScreen({super.key});

  @override
  State<NotLoggedScreen> createState() => _NotLoggedScreenState();
}

class _NotLoggedScreenState extends State<NotLoggedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Not logged"),
          ]
        )
      )
    );
  }
}
