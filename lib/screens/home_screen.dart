import 'dart:html';

import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Appbar of 1")),
        body: Column(
          children: [
            Text('this is 1st page'),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: Text("To 2nd screen"))
          ],
        ));
  }
}
