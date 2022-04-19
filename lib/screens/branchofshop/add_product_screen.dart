import 'package:flutter/material.dart';
import 'package:my_shopping_app/models/product.dart';
import 'package:my_shopping_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:my_shopping_app/services/firebase.dart';

TextEditingController mycontroller1 = TextEditingController();
TextEditingController mycontroller2 = TextEditingController();
TextEditingController mycontroller3 = TextEditingController();
TextEditingController mycontroller4 = TextEditingController();
Product newproduct = Product();

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temp = context.watch<ApplicationUser>();
    return Scaffold(
      body: Column(children: [
        TextField(
          controller: mycontroller1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Filtername',
            hintText: 'Enter Number',
          ),
        ),
        TextField(
          controller: mycontroller2,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
            hintText: 'Enter Number',
          ),
        ),
        TextField(
          controller: mycontroller3,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Price',
            hintText: 'Enter Number',
          ),
        ),
        TextField(
          controller: mycontroller4,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Description',
            hintText: 'Enter Number',
          ),
        ),
        TextButton(
            onPressed: () async {
              String? shopname = temp.name;
                var randomId = await getRandomProId();
              newproduct.edit(randomId, mycontroller1.text, mycontroller2.text,
                  mycontroller3.text, mycontroller4.text, shopname);
              var tempproductId = await newproduct.add();
              print(tempproductId);
              temp.addMyProduct(tempproductId);
              await temp.modeltodatabase();
              Navigator.pop(context);
            },
            child: Text("Add"))
      ]),
    );
  }
}
