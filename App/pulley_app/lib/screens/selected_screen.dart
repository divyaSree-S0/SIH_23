import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pulley_app/main.dart';
import 'package:pulley_app/screens/change_immediately.dart';
import 'package:pulley_app/screens/in_few_days.dart';

class Selected extends StatefulWidget {
  const Selected(this.conveyorId,{super.key});

  final Object conveyorId;

  @override
  State<Selected> createState() => _SelectedState();
}

class _SelectedState extends State<Selected> {

  @override
  void initState(){
    super.initState();
    remoteStore.setConveyorName(widget.conveyorId);
  }

  void _change() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Change();
        },
      ),
    );
  }

  void inFewDays() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const InFewDays();
        },
      ),
    );
  }

  final RefreshController _refreshcontroller =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      //remoteStore.setPulleyStatus();
    });
    _refreshcontroller.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(const Duration(seconds: 3));
    _refreshcontroller.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(remoteStore.conveyorName),
      ),
      body: SmartRefresher(
        controller: _refreshcontroller,
        onLoading: onLoading,
        onRefresh: onRefresh,
        enablePullDown: true,
        // enablePullUp: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 238, 177, 142),
                  ),
                  height: 70,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Text(
                          "Total Number of pulleys",
                          style:TextStyle(fontSize: 22),
                        ),
                        const Spacer(),
                        Text(
                          remoteStore.pulleysStatus.length.toString(),
                          style: const TextStyle(fontSize: 22),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 238, 177, 142)),
                  height: 70,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Text(
                          "Pulleys to be kept in stock: ",
                          style: TextStyle(fontSize: 22),
                        ),
                        const Spacer(),
                        Text(
                          remoteStore.pulleysToBeInStock.toString(),
                          style: const TextStyle(fontSize: 22),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 238, 177, 142),
                  ),
                  height: 130, //(MediaQuery.of(context).size.height) * 0.2,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Pulleys to be Changed: ",
                              style: TextStyle(fontSize: 25),
                            ),
                            const Spacer(),
                            Text(
                              remoteStore.damagedPulleys.length.toString(),
                              style: const TextStyle(fontSize: 25),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: _change,
                                child: const Text("Details",
                                    style: TextStyle(color: Colors.black))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: const Color.fromARGB(255, 238, 177, 142),
                //   ),
                //   height: (MediaQuery.of(context).size.height) * 0.2,
                //   width: double.infinity,
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       children: [
                //         const Text(
                //           "In few Days",
                //           style: TextStyle(fontSize: 36),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Text(
                //           remoteStore.pulleysToBeDamaged.length.toString(),
                //           style: TextStyle(fontSize: 30),
                //         ),
                //         ElevatedButton(
                //             onPressed: inFewDays,
                //             child: Text("Details",
                //                 style: TextStyle(color: Colors.black)))
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),

                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 238, 177, 142),
                  ),
                  height: 130,
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Pulleys working fine:",
                                style: TextStyle(fontSize: 25),
                              ),
                              const Spacer(),
                              Text(
                                remoteStore.pulleysWorkingFine.length
                                    .toString(),
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: _change,
                                  child: const Text("Details",
                                      style: TextStyle(color: Colors.black))),
                            ],
                          ),
                        ],
                      )),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
