import 'package:flutter/material.dart';
import 'package:lib_firebase/screens/add_book.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Home extends StatefulWidget {
@override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //GlobalKey<FormState> formKey = GlobalKey<FormState>(); //????????????????????????

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lib'),),
    body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
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
