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
  final _formkey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var username = '';
  bool isLoginPage = false;
  //---------------------

  startAuthentication(){
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState!.save();
      submitForm(email, password, username);
    }
  }
  submitForm(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential;
    try{
      if(isLoginPage){
        userCredential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      else{
        userCredential = await auth.createUserWithEmailAndPassword(
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
              key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isLoginPage)
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('User Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect User Name';
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
                          labelText: "Enter User Name"),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('E-Mail'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Incorrect E-mail';
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
                      labelText: "Enter E-Mail"),
                      ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('Password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect Password';
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
                              startAuthentication();
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