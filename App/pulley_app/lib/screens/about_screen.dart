import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("About Us")),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/PulleyWatch.png",
                    ),
                    Text(''' 
            PullyWatch is a smart monitoring application designed to enhance the maintenance and reliability of poly pulley systems. Leveraging advanced AI algorithms, this app continuously analyzes temperature data from pulleys, providing real-time insights into the condition of your machinery.
- *Proactive Maintenance:*
  PullyWatch enables proactive maintenance by identifying potential issues before they escalate, reducing downtime and preventing costly repairs.
- *Data-Driven Decision Making:*
  Make informed decisions based on real-time and historical data, optimizing the efficiency and lifespan of your poly pulley system.
- *Increased Productivity:*
  Minimize unplanned downtime and improve overall system reliability, leading to increased productivity and operational efficiency.
- *Cost Savings:*
  Identify and address pulley issues early, avoiding expensive replacements and reducing overall maintenance costs.
''', style: TextStyle(fontSize: 19), textAlign: TextAlign.justify),
                  ],
                ))));
  }
}
