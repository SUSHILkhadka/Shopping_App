import 'package:flutter/material.dart';
import 'package:my_shopping_app/services/firebase.dart';

class Review {
  String uid = "nullFromReview";
  String? rating;
  String? message;

  newreview(uid, rating, msg) {
    this.uid = uid;
    this.rating = rating;
    this.message = msg;
  }

  fromjsonToReview(userid, array) {
    this.uid = userid;
    this.rating = array[0];
    this.message = array[1];
  }

  Future<void> savetodatabase(productId) async {
    dynamic array = {this.rating, this.message};
    var map = {"${this.uid}": array};
    await updatereview(productId, map);
  }
}

class Product extends ChangeNotifier {
  String productId = 'default';
  String? filtername;
  String? name;
  String? price;
  String? description;
  String? shopname;
  String? averageRating;
  Product() {
    this.filtername = "default";
    this.name = "default";
    this.price = "default";
    this.description = "default";
    this.shopname = "default";
    this.averageRating = "default";
  }

  edit(randomid, a, b, c, d, shopname) {
    this.productId = randomid;
    this.filtername = a;
    this.name = b;
    this.price = c;
    this.description = d;
    this.shopname = shopname;
  }

  jsontoproduct(map) {
    if (map != null) {
      this.productId = map['productId'];
      this.filtername = map['filtername'];
      this.name = map['name'];
      this.price = map['price'];
      this.description = map['description'];
      this.shopname = map['shopname'];
      this.averageRating = map['averageRating'];
    }
  }

  Future<String> add() async {
    var jsonormap = {
      'productId': this.productId,
      'filtername': this.filtername,
      'name': this.name,
      'price': this.price,
      'description': this.description,
      'shopname': this.shopname,
      'averageRating': this.averageRating,
    };

    await ProductToDatabase(jsonormap, this.productId);
    return this.productId;
  }

  Future<void> productFromDatabase(productId) async {
    var map = await DatabasetoLocal_forproduct(productId);
    if (map != null) {
      this.productId = map['productId'];
      this.filtername = map['filtername'];
      this.name = map['name'];
      this.price = map['price'];
      this.description = map['description'];
      this.shopname = map['shopname'];
      this.averageRating = map['averageRating'];
    }
  }
}

class MyCart {
  String productId = 'defaultvalue_fromMyCart';
  String quantity = '1';

  MyCart(a, b) {
    this.productId = a;
    this.quantity = b;
  }

  edit(a, b) {
    this.productId = a;
    this.quantity = b;
  }

  unconcatinatedstring(String a) {
    String temp1 = '', temp2 = '';
    bool flick = false;

    a.runes.forEach((i) {
      var temp3 = String.fromCharCode(i);
      if (temp3 == '.') {
        flick = true;
      }
      if (flick == false) {
        temp1 = temp1 + temp3;
      } else {
        temp2 = temp2 + temp3;
      }
    });
    this.productId = temp1;
    this.quantity = temp2;
  }

  String concatinatedstring() {
    String temp;

    temp = productId + '.' + quantity;
    return temp;
  }
}

class MyDeals {
  String? userId;
  String? productId;
  int? quantity;
}
