import 'package:flutter/material.dart';
import 'package:pulley_app/main.dart';

class Change extends StatefulWidget {
  const Change({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _Change();
  }
}

class _Change extends State<Change>{

  void zoomImage(String imgSrc){
    showDialog(context: context, builder: (ctx) {
      return Center(
        child: Container(
          width: 350,
          height: 240,
          color: const Color.fromARGB(108, 0, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // Container(
              //   width: 300,
              //   height: 20,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //     IconButton(onPressed: (){Navigator.of(ctx).pop();}, icon:const Icon(Icons.cancel_outlined,color: Colors.white,)),
              //   ],),
              // ),

              Container(
                width: 350,
                height: 40,
                color: Color.fromARGB(108, 0, 0, 0),
                alignment: Alignment.centerRight,
                child: IconButton(onPressed: (){Navigator.of(ctx).pop();}, icon:const Icon(Icons.cancel_outlined,color: Colors.white,))),
              Image.network(imgSrc,width: 300,height: 200,),
              // Container(
              //   width: 350,
              //   height: 200,
              //   color: Color.fromARGB(108, 0, 0, 0),
              //   child: Image.network(imgSrc,width: 300,height: 200,)),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
     

    return Scaffold(
      appBar: AppBar(
        title: const Text("Change immediatly"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:Center(
          heightFactor: 0.5,
          child:SingleChildScrollView(
          child: DataTable(
          sortColumnIndex: 0,
          headingRowHeight: 35,
          columns: const [
            DataColumn(label: Text("Position")),
            DataColumn(label: Text("State")),
            DataColumn(label: Text("Image")),
          ],
          rows:
            remoteStore.damagedPulleys.map(
              (pulley) { 
                String originalLink = pulley["image"] as String;
                String fileId =
                  originalLink.substring(originalLink.indexOf('/d/') + 3, originalLink.indexOf('/view'));
                String newLink = 'https://drive.google.com/uc?export=view&id=$fileId';
                print(newLink);
                return DataRow(
                cells: [
                  DataCell(Text(pulley["pulleyLocation"].toString())),
                  DataCell(Text(pulley["status"].toString())),
                  DataCell(
                    IconButton(
                      icon:Image.network(newLink),
                      onPressed: (){zoomImage(newLink);},
                    ),
                  ),
                ]
              );} 
            ).toList(),
          //  [
          //   DataRow(cells: [
          //     DataCell(
          //       Text("54"),
          //     ),
          //     DataCell(
          //       Text("23"),
          //     ),
          //     DataCell(
          //       Text("95854"),
          //     ),
          //   ]),
          //   DataRow(cells: [
          //     DataCell(
          //       Text("hello"),
          //     ),
          //     DataCell(
          //       Text("hello"),
          //     ),
          //     DataCell(
          //       Text("hello"),
          //     ),
          //   ]),
          //   DataRow(cells: [
          //     DataCell(
          //       Text("hello"),
          //     ),
          //     DataCell(
          //       Text("hello"),
          //     ),
          //     DataCell(
          //       Text("hello"),
          //     ),
          //   ])
          // ],
        ),
        ), ),
         
         
      ),
    );
  }
}
