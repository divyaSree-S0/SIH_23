import 'package:flutter/material.dart';
import 'package:pulley_app/widgets/data_use.dart';

class FeedbackDialogue extends StatelessWidget {
  const FeedbackDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    void _dataprocess() {
      showDialog(context: context, builder: (ctx) => DataProcess());
    }

    return AlertDialog(
      title: Text("Please provide your valuable feedabck"),
      content: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            _dataprocess();
          },
          child: Text("Submit"),
        ),
      ],
    );
  }
}
