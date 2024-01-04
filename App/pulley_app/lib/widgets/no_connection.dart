import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:pulley_app/main.dart';
import 'package:pulley_app/modals/remote_store.dart';
import 'package:pulley_app/screens/splash_screen.dart';

class NoConnection extends StatelessWidget {
  NoConnection({super.key});

  void mainType() {
    remoteStore = RemoteStore.create();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> splashScreen() async {
      final result = await Connectivity().checkConnectivity();
      isConnected = result != ConnectivityResult.none;
      isConnected ? mainType() : null;
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (ctx) => const SplashScreen()));
      // Navigator.of(context).restorablePushReplacement(
      //     MaterialPageRoute(builder: (ctx) => const SplashScreen())
      //         as RestorableRouteBuilder<Object?>);
      // ignore: use_build_context_synchronously
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (ctx) => const SplashScreen()));
    }

    return AlertDialog(
      title: Text("NO INTERNET CONNECTION"),
      actions: [
        TextButton(
            onPressed: () {
              splashScreen();
            },
            child: Text("ok")),
      ],
    );
  }
}
