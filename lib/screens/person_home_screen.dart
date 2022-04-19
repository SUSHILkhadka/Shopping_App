import 'dart:html';

import 'package:flutter/material.dart';
import 'package:my_shopping_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:my_shopping_app/services/firebase.dart';

class PersonHomeScreen extends StatelessWidget {
  const PersonHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temp = context.watch<ApplicationUser>();
    return Scaffold(
      appBar: AppBar(title: Text("Appbar of 1")),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/allproductpage");
              },
              child: Text("Show product randomly")),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/mycartpage");
              },
              child: Text("My Cart")),
        ],
      ),
      drawer: Drawer(
          child: Column(
        children: [
          Text("name= ${temp.name}"),
          Text("Location= ${temp.location}"),
          Text("${temp.phoneNo}"),
          TextButton(
              onPressed: () {
                signout();
                Navigator.pushReplacementNamed(context, '/loginorregisterpage');
              },
              child: Text("SignOUt"))
        ],
      )),
    );
  }
}
