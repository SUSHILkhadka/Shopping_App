import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_shopping_app/models/user.dart';
import 'package:my_shopping_app/screens/branchofperson/all_product_screen.dart';
import 'package:my_shopping_app/screens/branchofshop/add_product_screen.dart';
import 'package:my_shopping_app/screens/branchofshop/my_products_screen.dart';
import 'package:my_shopping_app/screens/login_or_register_screen.dart';
import 'package:my_shopping_app/screens/person_home_screen.dart';
import 'package:my_shopping_app/screens/register_screen.dart';
import 'package:my_shopping_app/screens/shop_home_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/second_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBOCspEojAUEmuVq0VG3r8rVoTieQdeOgI",
          authDomain: "shoppingapp-193a3.firebaseapp.com",
          projectId: "shoppingapp-193a3",
          storageBucket: "shoppingapp-193a3.appspot.com",
          messagingSenderId: "317873543794",
          appId: "1:317873543794:web:e8c7a98bb01afde21440eb",
          measurementId: "G-LKXL06LG1V"));

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ApplicationUser())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/loginorregisterpage', routes: {
      '/': (context) => MyHomePage(),
      '/loginorregisterpage': (context) => LoginOrRegisterScreen(),
      '/registerpage': (context) => RegisterScreen(),
      '/shophomepage': (context) => ShopHomeScreen(),
      '/personhomepage': (context) => PersonHomeScreen(),
      '/addproductpage': (context)=> AddProductScreen(),
      '/myproductsscreen': (context)=>MyProductsScreen(),
      '/allproductpage':(context)=>AllProductScreen(),
    });
  }
}
