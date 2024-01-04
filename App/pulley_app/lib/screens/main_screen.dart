import 'dart:async';

import 'package:pulley_app/main.dart';
import 'package:pulley_app/screens/account_screen.dart';
import 'package:pulley_app/screens/screen.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _account() {
      remoteStore.userdetail();
      Timer(const Duration(seconds: 20), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => AccountScreen()));
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pulley Watch"),
        leading: IconButton(
          onPressed: _account,
          icon: const Icon(
            Icons.account_circle_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 10,
      ),
      body: const Screen(),
    );
  }
}
