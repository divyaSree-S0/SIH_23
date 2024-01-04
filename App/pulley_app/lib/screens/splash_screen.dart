import 'dart:async';
import 'package:pulley_app/main.dart';
import 'package:pulley_app/modals/constant.dart';
import 'package:pulley_app/screens/login_screen.dart';
import 'package:pulley_app/screens/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:pulley_app/widgets/no_connection.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  int once = 0;
  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of [TickerProviderStateMixin].
      vsync: this,
      duration: Duration(seconds: isConnected ? 15 : 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();

    userbox.isEmpty() ? null : last_user = userbox.getAll()[0];
    Timer(
      Duration(seconds: isConnected ? 15 : 3),
      () {
        controller.stop();
        isConnected
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  if (last_user == null) {
                    return const Login();
                  }
                  remoteStore.setUsersCollection(
                      last_user!.username.trim() + last_user!.userId.toString().trim());
                  return const Mainscreen();
                }),
              )
            : noconnection();
      },
    );

    super.initState();
  }

  void noconnection() {
    setState(() {
      showDialog(context: context, builder: ((ctx) => NoConnection()));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.isCompleted
        ? isConnected
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  if (last_user == null) {
                    return const Login();
                  }
                  remoteStore.setUsersCollection(
                      last_user!.username + last_user!.userId.toString());
                  return const Mainscreen();
                }),
              )
            : noconnection()
        : null;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/PulleyWatch.png',
              width: 300,
            ),
            //const Text('Damage Pulley Detector'),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: LinearProgressIndicator(
                value: controller.value,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
