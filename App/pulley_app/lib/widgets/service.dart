import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  const Service({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("System created Successfully"),
      content: Text(
          "For installment service Please contact\n\n+91265634858\n+914578658745"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            const snackbar = SnackBar(content: Text("created succucessfully"));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },
          child: Text("Ok"),
        ),
      ],
    );
  }
}
