import 'package:flutter/material.dart';
import 'package:pulley_app/main.dart';
import 'package:pulley_app/widgets/service.dart';

String errorstring = '';

class create extends StatefulWidget {
  const create({super.key});

  @override
  State<create> createState() => _CreateState();
}

class _CreateState extends State<create> {
  String shoe = '';
  TextEditingController name = TextEditingController();
  TextEditingController pullryno = TextEditingController();
  TextEditingController shoear = TextEditingController();
  TextEditingController thick = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController mine = TextEditingController();
  TextEditingController industry = TextEditingController();

  Future checker() async {
    if (name.text.isEmpty) {
      setState(() {
        errorstring = "Enter the Name";
      });
      return;
    }
    if (pullryno.text.isEmpty || int.tryParse(pullryno.text)! >= 10) {
      setState(() {
        errorstring = "Enter the Total number of pulleys";
      });
      return;
    }
    if (shoe.isEmpty) {
      setState(() {
        errorstring = "Enter the number of pulleys in shoe architecture";
      });
      return;
    }

    if (thick.text.isEmpty) {
      setState(() {
        errorstring = "Enter the thickness of the belt";
      });
      return;
    }
    if (width.text.isEmpty) {
      setState(() {
        errorstring = "Enter the width of the belt";
      });
      return;
    }
    if (length.text.isEmpty) {
      setState(() {
        errorstring = "Enter the length of the belt";
      });
      return;
    }
    if (mine.text.isEmpty) {
      setState(() {
        errorstring = "Enter the mine location";
      });
      return;
    }
    if (industry.text.isEmpty) {
      setState(() {
        errorstring = "Enter the industry location";
      });
      return;
    } else {
      Navigator.of(context).pop();
      service();
      String name1 = name.text;
      int pulleyno1 = int.tryParse(pullryno.text)!;
      int shoe1 = int.tryParse(shoe)!;
      double thick1 = double.tryParse(thick.text)!;
      double width1 = double.tryParse(width.text)!;
      double length1 = double.tryParse(length.text)!;
      String mine1 = mine.text;
      String industry1 = industry.text;
      remoteStore.createConveyor(
          name: name1,
          totalPulleys: pulleyno1,
          pulleysInShoe: shoe1,
          beltThickness: thick1,
          beltLength: length1,
          beltWidth: width1,
          mine: mine1,
          industry: industry1);
    }
    remoteStore.setConveyors();
    return;
  }

  @override
  void dispose() {
    super.dispose();
    pullryno.dispose();
    name.dispose();
    thick.dispose();
    width.dispose();
    length.dispose();
    mine.dispose();
    industry.dispose();
  }

  void service() {
    showDialog(context: context, builder: (ctx) => const Service());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const Text("Cable Conveyor Details",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
          TextField(
            controller: name,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text("Name"),
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: pullryno,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text("Total number of pulleys in the system")),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              const Expanded(
                child: Text("Number of pulley in shoe architecture"),
              ),
              Expanded(
                  child: RadioListTile(
                title: Text("1"),
                value: "1",
                groupValue: shoe,
                onChanged: (value) {
                  setState(
                    () {
                      shoe = value.toString();
                    },
                  );
                },
              )),
              //SizedBox(width:10),
              Expanded(
                  child: RadioListTile(
                title: Text("2"),
                value: "2",
                groupValue: shoe,
                onChanged: (value) {
                  setState(
                    () {
                      shoe = value.toString();
                    },
                  );
                },
              )),
            ],
          ),
          SizedBox(height: 8),
          const Text("Belt Details"),
          Row(children: [
            Expanded(
                child: TextField(
              controller: thick,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(label: Text("Thickness"), suffixText: "mm"),
            )),
            SizedBox(width: 10),
            Expanded(
                child: TextField(
              controller: width,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(label: Text("Length"), suffixText: "km"),
            )),
            SizedBox(width: 10),
            Expanded(
                child: TextField(
              controller: length,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(label: Text("Width"), suffixText: "mm"),
            ))
          ]),
          SizedBox(height: 8),
          TextField(
            controller: mine,
            keyboardType: TextInputType.streetAddress,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
              label: Text("Mine Location"),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: industry,
            keyboardType: TextInputType.streetAddress,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
              label: Text(
                "Industry Location",
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            errorstring,
            textAlign: TextAlign.start,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            SizedBox(width: 3),
            ElevatedButton(
              autofocus: true,
              onPressed: () {
                checker();
              },
              child: Text("Submit"),
            )
          ]),
          Container(height: 200),
          Container(height: 200),
        ],
      ),
    );
  }
}
