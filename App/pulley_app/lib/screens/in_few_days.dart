import 'package:flutter/material.dart';

class InFewDays extends StatelessWidget {
  const InFewDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change in few Days"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DataTable(
          border: TableBorder.all(color: Colors.black),
          columns: [
            DataColumn(label: Text("Percentage")),
            DataColumn(label: Text("Position")),
            DataColumn(label: Text("Image")),
          ],
          rows: const [
            DataRow(cells: [
              DataCell(
                Text("54"),
              ),
              DataCell(
                Text("23"),
              ),
              DataCell(
                Text("95854"),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text("hello"),
              ),
              DataCell(
                Text("hello"),
              ),
              DataCell(
                Text("hello"),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text("hello"),
              ),
              DataCell(
                Text("hello"),
              ),
              DataCell(
                Text("hello"),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
