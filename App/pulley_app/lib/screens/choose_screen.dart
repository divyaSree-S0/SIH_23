import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pulley_app/main.dart';
import 'package:pulley_app/screens/selected_screen.dart';

// ignore: must_be_immutable
class Choose extends StatefulWidget {
  Choose(this.list, {super.key});

  List<(String, Object)> list;

  @override
  State<Choose> createState() {
    return _Choose();
  }
}

class _Choose extends State<Choose> with TickerProviderStateMixin {
  //List<String> items = ["hello", "hi", "everyone"];
  late AnimationController controller;
  final RefreshController _refreshcontroller =
      RefreshController(initialRefresh: false);
  void onRefresh() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      widget.list = remoteStore.conveyors;
    });
    _refreshcontroller.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(const Duration(seconds: 3));
    _refreshcontroller.loadComplete();
  }

  void _choosen(Object conveyorId) {
    remoteStore.setPulleyStatus(conveyorId);
    Timer(const Duration(seconds: 20), () {
      remoteStore.setPulleysCondition();
      remoteStore.setConveyorName(conveyorId);
      Timer(const Duration(seconds: 15), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Selected(conveyorId)));
    });
    });
    
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    
    
    
    super.initState();
  }

  void dialogue() {
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: CircularProgressIndicator(
              value: controller.value,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          );
        });
  }

  @override
  void dispose() {
    
      controller.stop();
    controller.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watch System"),
      ),
      body: SmartRefresher(
          controller: _refreshcontroller,
          onLoading: onLoading,
          onRefresh: onRefresh,
          enablePullDown: true,
          // enablePullUp: true,
          header: const WaterDropHeader(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const Divider(height: 10.0),
                itemCount: widget.list.length,
                //itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: const Color.fromARGB(255, 238, 177, 142),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(widget.list[index].$1),
                    trailing: ElevatedButton(
                      child: const Text(
                        "Watch",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        dialogue();
                        _choosen(widget.list[index].$2);
                        
                      },
                    ),
                  );
                }),
          )),
    );
  }
}
