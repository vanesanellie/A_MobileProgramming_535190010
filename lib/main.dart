import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Poke App",
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
    @override
    HomePageState createState() {
      return new HomePageState();
    }
  }
  
class HomePageState extends State<HomePage> {

  

  @override
  void initState(){
    super.initState();
    fetchData();
  }

    fetchData() async {}

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Poke App"),
        ),
        body: Center(
          child: Text("Hello from me ^v^"),
        ), 
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.refresh)
            ),
    );
    return scaffold;
    

    
  }
}
