import 'dart:html';

import 'package:flutter/material.dart';
import 'package:my_shopping_app/services/firebase.dart';
import 'package:provider/provider.dart';
import 'package:my_shopping_app/models/user.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temp = context.watch<ApplicationUser>();
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ApplicationUser())],
        child: Scaffold(
          appBar: AppBar(title: Text("Appbar of 1")),
          drawer: Drawer(
              child: Column(
            children: [
              Text("name= ${temp.name}"),
              Text("Location= ${temp.location}"),
              Text("${temp.phoneNo}"),
              Text(temp.myProducts.length.toString()),
              TextButton(
                  onPressed: () {
                    signout();
                    Navigator.pushReplacementNamed(
                        context, '/loginorregisterpage');
                  },
                  child: Text("SignOUt"))
            ],
          )),
          body: Column(children: [
            TextButton(onPressed: () {
              Navigator.pushNamed(context, '/myproductsscreen');
            }, child: Text("My Products")),
            TextButton(onPressed: () {}, child: Text('My Deals')),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addproductpage');
                },
                child: Text('Add Product')),
          ]),
        ));
  }
}
