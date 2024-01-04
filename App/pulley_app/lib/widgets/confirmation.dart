import 'package:flutter/material.dart';

class ConfirmationDialogue extends StatelessWidget {
  ConfirmationDialogue(this.conveyorId, this._dialoguebox, {super.key});
  final Object conveyorId;
  final void Function(Object) _dialoguebox;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure you want to remove the system"),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => Color.fromARGB(255, 235, 156, 111)),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => Color.fromARGB(255, 235, 156, 111)),
          ),
          onPressed: () {
            Navigator.pop(context);
            _dialoguebox(conveyorId);
          },
          child: Text("Submit"),
        ),
      ],
    );
  }
}
