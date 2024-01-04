import 'package:pulley_app/main.dart';
import 'package:pulley_app/screens/choose_screen.dart';
import 'package:pulley_app/screens/remove_screen.dart';
import 'package:pulley_app/widgets/create.dart';

import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Screen();
  }
}

class _Screen extends State<Screen> {
  void _createsytsem() {
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        //showDragHandle: true,
        context: context,
        builder: (ctx) {
          return create();
        });
  }

  void _removesystem() {
    final List<(String, Object)> list = remoteStore.conveyors;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Remove(list);
        },
      ),
    );
  }

  void _choosesystem() {
    final List<(String, Object)> list = remoteStore.conveyors;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Choose(list);
        },
      ),
    );
  }

  // void feedbackeer() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return FeedbackDialogue();
  //       },
  //     ),
  //   );
  // }
  // void feedbackeer() {
  //   setState(() {
  //     showDialog(context: context, builder: ((ctx) => FeedbackDialogue()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    remoteStore.setConveyors();
    //feedbackeer();
    // print("refresh");
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 238, 177, 142),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Watch Sytsem",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                          '''\n• Watch out the pulleys on a conveyor belt.\n• Look at the pulleys about to be damaged.\n• Note the number of pulleys to be in stock.'''),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: _choosesystem,
                            child: const Text("Watch")),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 238, 177, 142),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Install Sytsem",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                          '''\n• Add required details of the cable conveyor.\n• Contact the technicians for sevice. \n• Install the required setup.'''),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: _createsytsem,
                            child: const Text("Create")),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 238, 177, 142),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_circle,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Remove Sytsem",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                          "\n• Remove conveyor to stop the service.\n• Provide valuable feedback.\n• Share data to make us better."),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: _removesystem,
                            child: const Text("Remove")),
                        const SizedBox(width: 20),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 238, 177, 142),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call),
                        SizedBox(width: 20),
                        Text(
                          "Customer Care",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("\n• 18005-73984\n• 18007-31974"),
                        SizedBox(height: 10),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}




// void settings(BuildContext ctxxxxx) {
//     Navigator.of(ctxxxxx).push(
//       MaterialPageRoute(
//         builder: (_) {
//           return (){};
//         },
//       ),
//     );
//   }

