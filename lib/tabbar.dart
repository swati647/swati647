import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(

        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25.0)
                ),
                child:  TabBar(
                  indicator: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius:  BorderRadius.circular(25.0)
                  ) ,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const  [
                    Tab(text: 'Chats',),
                    Tab(text: 'Status',),
                    Tab(text: 'Calls',),
                    Tab(text: 'Settings',)
                  ],
                ),
              ),
              const Expanded(
                  child: TabBarView(
                    children:  [
                      Center(child: Text("Chats Pages"),),
                      Center(child: Text("Status Pages"),),
                      Center(child: Text('Calls Page'),),
                      Center(child: Text('Settings Page'),)
                    ],
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}