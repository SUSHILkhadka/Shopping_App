import 'package:flutter/material.dart';
import 'package:my_shopping_app/services/firebase.dart';
import 'package:provider/provider.dart';
import 'package:my_shopping_app/models/user.dart';

TextEditingController mycontroller1 = TextEditingController();
TextEditingController mycontroller2 = TextEditingController();
TextEditingController mycontroller3 = TextEditingController();
TextEditingController mycontroller4 = TextEditingController();
TextEditingController mycontroller5 = TextEditingController();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var temp = context.watch<ApplicationUser>();
    return Scaffold(
        body: Column(
      children: [
        TextField(
          controller: mycontroller1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'userlevel',
            hintText: 'Enter userlevel',
          ),
        ),
        TextField(
          controller: mycontroller2,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
            hintText: 'Enter Name',
          ),
        ),
        TextField(
          controller: mycontroller3,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Location',
            hintText: 'Enter Location',
          ),
        ),
        TextField(
          controller: mycontroller4,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Number',
            hintText: 'Enter Number',
          ),
        ),
        TextButton(
            onPressed: () async {
              await temp.edit(int.parse(mycontroller1.text), mycontroller2.text,
                  mycontroller3.text, mycontroller4.text);
              temp.modeltodatabase();
                             if(temp.userLevel==1)
                Navigator.pushNamed(context, '/shophomepage');
                else
                Navigator.pushNamed(context, '/personhomepage');
            },
            child: Text("Proceed"))
      ],
    ));
  }
}
