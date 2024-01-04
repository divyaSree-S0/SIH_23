import 'dart:async';

import 'package:pulley_app/modals/constant.dart';
import 'package:pulley_app/modals/local_store.dart';
import 'package:pulley_app/modals/notifications.dart';
import 'package:pulley_app/modals/remote_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pulley_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

late ObjectBox objectbox;
late RemoteStore remoteStore;

ThemeData ttheme = ThemeData.light().copyWith(
  useMaterial3: true,
  appBarTheme: const AppBarTheme().copyWith(
    color: Colors.white,
  ),
  colorScheme: kLightColorScheme,
  textTheme: GoogleFonts.sanchezTextTheme(),

  //colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
);
ThemeData dtheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  appBarTheme: const AppBarTheme().copyWith(
    color: Colors.black,
  ),
  colorScheme: kDarkColorScheme,
  //colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
);

bool isConnected = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final result = await Connectivity().checkConnectivity();
  isConnected = result != ConnectivityResult.none;
  print(result);
  print(isConnected);
  notification();

  objectbox = await ObjectBox.create();

  if (isConnected) {
    remoteStore = RemoteStore.create();
  }

  runApp(const MyApp());
}

// connection() {
//   bool isconnected =
//       Connectivity().checkConnectivity() != ConnectivityResult.none;
//   print(isconnected);
//   if (isconnected) {
//     return NoConnection();
//   } else
//     return SplashScreen();
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        title: 'Bit.exe',
        theme: ttheme,
        darkTheme: dtheme,
        home: const SplashScreen());
  }
}
