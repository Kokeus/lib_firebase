import 'package:flutter/material.dart';
import 'package:lib_firebase/screens/add_book.dart';




class Home extends StatefulWidget {
@override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lib'),),
    body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
    ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBook()));
        }),
    );
  }
}
