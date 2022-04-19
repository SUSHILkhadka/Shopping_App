import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shopping_app/models/product.dart';
import 'package:my_shopping_app/services/firebase.dart';
import 'package:provider/provider.dart';

class ApplicationUser with ChangeNotifier {
  String? uid;
  int? userLevel;
  String? name;
  String? location;
  String? phoneNo;
  List<dynamic> myProducts = ['firstValue'];
  List<dynamic> myCart = [];
  MyDeals? myDeals;

  Future<void> edit(b, c, d, e) async {
    String a = await getuid();
    this.uid = a;
    this.userLevel = b;
    this.name = c;
    this.location = d;
    this.phoneNo = e;
  }

  addMyProduct(String productId) {
    this.myProducts.add(productId);
    notifyListeners();
  }

  modeltodatabase() async {
    var jsonormap = {
      'uid': this.uid,
      'userLevel': this.userLevel,
      'name': this.name,
      'location': this.location,
      'phoneNo': this.phoneNo,
      'myProducts': this.myProducts,
      'myDeals': this.myDeals,
      'myCart': this.myCart,
    };
    await LocalToDatabase(jsonormap);
  }

  modelfromdatabase() async {
    var map = await DatabasetoLocal();
    if (map != null) {
      this.uid = map['uid'];
      this.userLevel = map['userLevel'];
      this.name = map['name'];
      this.location = map['location'];
      this.phoneNo = map['phoneNo'];
      this.myProducts = map['myProducts'];
      this.myDeals = map['myDeals'];
      this.myCart = map['myCart'];
    }
  }

  addToMyCart(productId, quantity) {
    MyCart a = MyCart(productId, quantity);
    var temp = a.concatinatedstring();
    this.myCart.add(temp);
    notifyListeners();
  }
}
