import 'package:flutter/material.dart';

class DataProcess extends StatelessWidget {
  const DataProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Can we use yor data for the betterment of our service"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("No"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}
