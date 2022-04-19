import 'package:flutter/material.dart';
import 'package:my_shopping_app/services/firebase.dart';
import 'package:provider/provider.dart';
import 'package:my_shopping_app/models/user.dart';

TextEditingController mycontroller1 = TextEditingController();
TextEditingController mycontroller2 = TextEditingController();
int loginstat = 1;

List<String> text = [
  "logged in successfully",
  "some unknown error",
  " No user found",
  " wrong password"
];

var snackbar_object0 = SnackBar(
  content: Text(text[0]),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);
var snackbar_object1 = SnackBar(
  content: Text(text[1]),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);

var snackbar_object2 = SnackBar(
  content: Text(text[2]),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);

var snackbar_object3 = SnackBar(
  content: Text(text[3]),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);

class LoginOrRegisterScreen extends StatelessWidget {
  const LoginOrRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temp = context.watch<ApplicationUser>();
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: mycontroller1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'email',
              hintText: 'Enter email',
            ),
          ),
          TextField(
            controller: mycontroller2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: 'Enter Password',
            ),
          ),
          TextButton(
              onPressed: () async {
                await register(mycontroller1.text, mycontroller2.text);
                Navigator.pushNamed(context, "/registerpage");
              },
              child: Text("Register")),
          TextButton(
              onPressed: () async {
                // loginstat =
                // await signin(mycontroller1.text, mycontroller2.text);
                loginstat = await signin("k@gmail.com", "aaaaaa");
                if (loginstat == 1) {
                  ScaffoldMessenger.of(context).showSnackBar(snackbar_object1);
                } else if (loginstat == 2) {
                  ScaffoldMessenger.of(context).showSnackBar(snackbar_object2);
                } else if (loginstat == 3) {
                  ScaffoldMessenger.of(context).showSnackBar(snackbar_object3);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(snackbar_object0);
                }
                await temp.modelfromdatabase();
                if (temp.userLevel == 1)
                  Navigator.pushNamed(context, '/shophomepage');
                else
                  Navigator.pushNamed(context, '/personhomepage');
              },
              child: Text("Login")),
        ],
      ),
    );
  }
}
