import 'package:flutter/material.dart';
import 'package:pulley_app/main.dart';
import 'package:pulley_app/modals/constant.dart';
import 'package:pulley_app/modals/logged_in_user.dart';
import 'package:pulley_app/screens/main_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isError = false;
  String errorString = '';
  bool obscureText= true;

  Future<void> login() async {
    print('kaha');
    if (username.text.isEmpty) {
      setState(() {
        errorString = 'Enter Username.';
      });
      return;
    }
    if (password.text.isEmpty) {
      setState(() {
        errorString = 'Enter password';
      });
      return;
    }

    int check = await remoteStore.isValidUser(username.text, password.text);
    switch (check) {
      case -1:
        setState(() {
          errorString = 'Incorrect Username';
        });
      case 0:
        setState(() {
          errorString = 'Incorrect Password';
        });
      case _:
        last_user = Users(check ,username.text, password.text);
        userbox.removeAll();
        userbox.put(last_user!);
        remoteStore
            .setUsersCollection("${last_user!.username.trim()}${last_user!.userId.toString().trim()}");
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const Mainscreen()));
    }
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_sharp,
            size: 150,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: username,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: password,
              keyboardType: TextInputType.text,
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: obscureText
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.visibility_off_outlined)),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            errorString,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 5),
          ElevatedButton(onPressed: login, child: const Text('Log-in')),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('If not registered.'),
            InkWell(
              child: const Text(
                'Register Now',
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              ),
              onTap: () =>
                  launchUrlString('https://mines.gov.in/webportal/home'),
            ),
          ]),
        ],
      ),
    );
  }
}
