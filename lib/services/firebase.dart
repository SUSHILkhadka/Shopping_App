import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:html';
import 'package:my_shopping_app/models/user.dart';

Future<void> register(String name, String passwor) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: name, password: passwor);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  }
}

Future<int> signin(String name, String passwor) async {
  int result = 0;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: name, password: passwor);
  } on FirebaseAuthException catch (e) {
    result = 1;
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      result = 2;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      result = 3;
    }
  }

  var firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser == null) {
    print('user is null');
  }
  if (firebaseUser != null) {
    print("current user's uid isnot NULL.uid= ");
    print(firebaseUser.uid);
  }

  return result;
}

void signout() async {
  await FirebaseAuth.instance.signOut();
  var firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser == null) {
    print("signed out successfully with id= $firebaseUser.uid");
  }
  if (firebaseUser != null) {
    print("user isnot null");
  }
}

Future<String> giveuid() async {
  String temp = 'defaultUID';
  var a = await FirebaseAuth.instance.currentUser;
  if (a != null) {
    temp = a.uid;
  }
  return temp;
}

Future<void> LocalToDatabase(var jsonORmap) async {
  var a = await FirebaseAuth.instance.currentUser;
  if (a != null) {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc('${a.uid}')
        .set(jsonORmap);
  }
}

// Future<String> ProductToDatabase(var json) async {
//   var a = await FirebaseAuth.instance.currentUser;
//   var productId = '';
//   if (a != null) {
//     await FirebaseFirestore.instance
//         .collection('Products')
//         .add(json)
//         .then((documentReference) => productId = documentReference.id);
//   }
//   return productId;
// }

Future<String> ProductToDatabase(var json, String docid) async {
  var a = await FirebaseAuth.instance.currentUser;
  var productId = '';
  if (a != null) {
    await FirebaseFirestore.instance
        .collection('Products')
        .doc('${docid}')
        .set(json);
  }
  return productId;
}

Future<Map<String, dynamic>?> DatabasetoLocal() async {
  var a = await FirebaseAuth.instance.currentUser;
  var json;
  if (a != null) {
    var snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(a.uid).get();

    if (snapshot.exists) {
      print(snapshot.data());
      json = snapshot.data();
    }

    // Stream for_dynamicWidgets =
    //     FirebaseFirestore.instance.collection('appUser').doc(a.uid).snapshots();
    // for_dynamicWidgets.listen((event) {
    //   print(event['name']);
    //   json = event;
    // });
  }
  return json;
}

Future<Map<String, dynamic>?> DatabasetoLocal_forproduct(
    String ProductId) async {
  var a = await FirebaseAuth.instance.currentUser;
  var json;
  if (a != null) {
    var snapshot = await FirebaseFirestore.instance
        .collection('Products')
        .doc(ProductId)
        .get();

    if (snapshot.exists) {
      print(snapshot.data());
      json = snapshot.data();
    }

    // Stream for_dynamicWidgets =
    //     FirebaseFirestore.instance.collection('appUser').doc(a.uid).snapshots();
    // for_dynamicWidgets.listen((event) {
    //   print(event['name']);
    //   json = event;
    // });
  }
  return json;
}

// void read() async {
//   AppUser appUser = AppUser();
//   var a = FirebaseAuth.instance.currentUser;
//   if (a != null) {
//     var collection =
//         await FirebaseFirestore.instance.collection('appUser').doc(a.uid).get();
//     var json = collection.data();
//     print(json);
//     var b = json as Map<String, dynamic>;
//     print('name is is ${json['name']}');
//     appUser.fromMapToModel(b);
//     print(appUser.name);
//   }
// }

Future<String> getuid() async {
  var a = await FirebaseAuth.instance.currentUser;
  var temp = 'default uid';
  if (a != null) {
    temp = a.uid;
  }
  return temp;
}

Future<String> getRandomProId() async {
  var id = await FirebaseFirestore.instance.collection("Products").doc().id;
  return id;
}

Future<List<Map<String, dynamic>?>> DatabasetoLocal_forAllproduct() async {
  var a = await FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> json = [];
  if (a != null) {
    var snapshot =
        await FirebaseFirestore.instance.collection('Products').get();

    if (snapshot.docs.isNotEmpty) {
      for (var i in snapshot.docs) {
        print(i.data());
        json.add(i.data());
      }
    }

    // Stream for_dynamicWidgets =
    //     FirebaseFirestore.instance.collection('appUser').doc(a.uid).snapshots();
    // for_dynamicWidgets.listen((event) {
    //   print(event['name']);
    //   json = event;
    // });
  }
  return json;
}



Future<Map<String, dynamic>?>  DatabasetoLocal_forAllReviewofaProduct(product) async {
  var a = await FirebaseAuth.instance.currentUser;
  var json;
  if (a != null) {
    var snapshot = await FirebaseFirestore.instance
        .collection('Reviews')
        .doc(product.productId)
        .get();

    if (snapshot.exists) {
      print(snapshot.data());
      json = snapshot.data();
    }

    // Stream for_dynamicWidgets =
    //     FirebaseFirestore.instance.collection('appUser').doc(a.uid).snapshots();
    // for_dynamicWidgets.listen((event) {
    //   print(event['name']);
    //   json = event;
    // });
  }
  return json;
}


Future<void> updatereview(productId, map) async {
  var a = await FirebaseAuth.instance.currentUser;
  if (a != null) {
    await FirebaseFirestore.instance
        .collection('Reviews')
        .doc('${productId}')
        .update(map);
  }
}