import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  //---------------------
  final _fromkey = GlobalKey<FormState>();
  var email;
  var  password;
  var username;
  bool isLoginPage = false;
  //---------------------

  startAuthentication(){
    var _formkey;
    final validity = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState.save();
      submitForm(email!, password!, username!); //?
    }
  }

  submitForm(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;

    UserCredential userCredential;
    try{
      if(isLoginPage){
        userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
      else{
        userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'username': username, 'email':email});
          }
        }
    catch (err){
      print(err);
    }
  }

  //---------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Form(
              key: _fromkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isLoginPage) // строка 15
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              borderSide: new BorderSide()),
                          labelText: "Enter username"),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Incorrect Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide()),
                      labelText: "Enter Email"),
                      ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              borderSide: new BorderSide()),
                          labelText: "Enter Password"),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 70,
                        child: ElevatedButton (
                          child: isLoginPage? Text('Login') :Text('SignUp'),
                            onPressed: () {

                            })),
                    SizedBox(height: 10),
                    Container (
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            isLoginPage = !isLoginPage;
                          });
                        }, child: isLoginPage?Text('Not a member?'): Text('Already a Member ?'),),)
                  ],
                ),
          ))
        ],
      ));
  }
}

