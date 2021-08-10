import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New book')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Enter Title', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Enter Description', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text('Add book'),
                  onPressed: (){},
                ))
          ],
        ),
      ),
    );
  }
}
