import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pulley_app/main.dart';
import 'package:pulley_app/widgets/confirmation.dart';
import 'package:pulley_app/widgets/feedback.dart';

// ignore: must_be_immutable
class Remove extends StatefulWidget {
  Remove(this.conveyorList, {super.key});

  List<(String, Object)> conveyorList;

  @override
  State<StatefulWidget> createState() {
    return _Remove();
  }
}

class _Remove extends State<Remove> {
  //List<String> items = ["hello", "hi", "everyone"];
  final RefreshController _refreshcontroller =
      RefreshController(initialRefresh: false);
  void onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      widget.conveyorList = remoteStore.conveyors;
    });
    _refreshcontroller.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      widget.conveyorList = remoteStore.conveyors;
    });
    _refreshcontroller.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    List<(String, Object)> list = widget.conveyorList;

    void _dialoguebox(Object conveyorId) {
      remoteStore.removeConveyor(conveyorId);
      showDialog(
          context: context,
          builder: ((ctx) {
            return const FeedbackDialogue();
          }));
      Timer(const Duration(seconds: 15), () => remoteStore.setConveyors);
    }

    void confirmation(Object conveyorId) {
      remoteStore.setConveyorName(conveyorId);
      showDialog(
          context: context,
          builder: (ctx) => ConfirmationDialogue(conveyorId, _dialoguebox));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Remove System"),
        ),
        body: SmartRefresher(
            controller: _refreshcontroller,
            onLoading: onLoading,
            onRefresh: onRefresh,
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(height: 10.0),
                    scrollDirection: Axis.vertical,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: Color.fromARGB(255, 238, 177, 142),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: Text(list[index].$1,
                            style: TextStyle(fontSize: 16)),
                        trailing: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Color.fromARGB(255, 235, 156, 111))),
                          child: Text("Remove",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          onPressed: () {
                            confirmation(list[index].$2);
                          },
                        ),
                      );
                    }))));
  }
}
