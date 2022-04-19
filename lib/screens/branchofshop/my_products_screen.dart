import 'package:flutter/material.dart';
import 'package:my_shopping_app/models/product.dart';
import 'package:my_shopping_app/services/firebase.dart';
import 'package:provider/provider.dart';
import 'package:my_shopping_app/models/user.dart';

class MyProductsScreen extends StatefulWidget {
  MyProductsScreen({Key? key}) : super(key: key);

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  @override
  Widget build(BuildContext context) {
    var temp = context.watch<ApplicationUser>(); // STEP 1

    Future<List<Product>> getProductsList() async {
      //STEP 2
      List<Product> a = [];
      for (var i in temp.myProducts) {
        Product b = Product();
        await b.productFromDatabase(i);
        print("for productID= $i , productname=${b.name}");
        a.add(b);
      }
      return a;
    }

    return Scaffold(
        body: FutureBuilder(
      //STEP 3
      future: getProductsList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Text("Loading");
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length -
                  1, // // index+1 is used because index always starts from 0 and we set "length" to "length-1" and "index" to "index+1" such that we start from " 1 to length "
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: Colors.blue,
                  title: Text(snapshot.data[index + 1].name),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                EditScreen(a: snapshot.data[index + 1]))));
                  },
                );
              });
        }
      },
    ));
  }
}

class EditScreen extends StatelessWidget {
  final Product a;

  const EditScreen({Key? key, required this.a}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mycontroller1 = TextEditingController();
    var mycontroller2 = TextEditingController();
    return Scaffold(
        body: Column(
      children: [
        Text("Previous name is ${a.name}"),
        TextField(
          controller: mycontroller1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'New name',
            hintText: 'Enter new name',
          ),
        ),
        Text("Previous price is ${a.price}"),
        TextField(
          controller: mycontroller2,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'new price ',
            hintText: 'Enter new price',
          ),
        ),
        TextButton(
            onPressed: () async {
              a.edit(a.productId, a.filtername, mycontroller1.text,
                  mycontroller2.text, a.description, a.shopname);
              await a.add();
              Navigator.pushNamedAndRemoveUntil(context, '/shophomepage', (route) => false);
            },
            child: Text("Save"))
      ],
    ));
  }
}
