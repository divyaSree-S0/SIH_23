import 'package:flutter/material.dart';
import 'package:pulley_app/main.dart';
import 'package:pulley_app/modals/constant.dart';
import 'package:pulley_app/screens/about_screen.dart';
import 'package:pulley_app/screens/login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void _about() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AboutScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account")),
      body: Container(
          child: ListView(
        children: [
          //Icon(Icons.account_circle,),
          ListTile(
            title: Text("Username"),
            subtitle: Text(last_user!.username),
          ),
          ListTile(
            title: Text("Industry Name"),
            subtitle: Text(remoteStore.industryName),
          ),
          ListTile(
            title: Text("Industry Location"),
            subtitle: Text(remoteStore.industryLocation),
          ),
          ListTile(
            title: Text("email-id"),
            subtitle: Text(remoteStore.email),
          ),
          ListTile(title: Text("About"), onTap: _about),
          ListTile(
            title: Text("Logout"),
            onTap: () {
              userbox.removeAll();
              last_user = null;
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const Login()));
            },
          ),
        ],
      )),
    );
  }
}
