import 'package:flutter/material.dart';
import 'package:my_shopping_app/models/product.dart';
import 'package:my_shopping_app/services/firebase.dart';
import 'package:provider/provider.dart';
import 'package:my_shopping_app/models/user.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Product>> getallProduct() async {
      List<Product> a = [];

      List<Map<String, dynamic>?> listofjson =
          await DatabasetoLocal_forAllproduct();
      for (int i = 0; i < listofjson.length; i++) {
        Product b = Product();
        b.jsontoproduct(listofjson[i]);
        b.name;
        a.add(b);
      }

      return a;
    }

    return Scaffold(
      body: FutureBuilder(
          future: getallProduct(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Text("Loading");
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      tileColor: Colors.blue,
                      title: Text(snapshot.data[index].name),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ProductViewScreen(
                                    a: snapshot.data[index]))));
                      },
                    );
                  });
            }
          }),
    );
  }
}

class ProductViewScreen extends StatelessWidget {
  final Product a;
  const ProductViewScreen({Key? key, required this.a}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var temp = context.watch<ApplicationUser>();
    print("right aftr widget build uid is ${temp.uid}");
    Review Myreview = Review();

    Future<List<Review>> getallreviews(a) async {
      List<Review> reviewList = [];
      Map<String, dynamic>? b = await DatabasetoLocal_forAllReviewofaProduct(a);

      b?.forEach((key, value) {
        Review c = Review();
        c.fromjsonToReview(key, value);
        reviewList.add(c);
      });

      return reviewList;
    }

    Future<Review> hascommented(a) async {
      Review myreview = Review();
      Map<String, dynamic>? b = await DatabasetoLocal_forAllReviewofaProduct(a);
      if (b?[temp.uid] != null) {
        myreview.fromjsonToReview(temp.uid, b?[temp.uid]);
      }

      return myreview;
    }

    var mycontroller2 = TextEditingController();
    var mycontroller1 = TextEditingController();
    var mycontroller3 = TextEditingController();
    bool notAddedToCart = true;
    String quantity = '1';
    if (temp.myCart != null) {
      temp.myCart.forEach((i) {
        MyCart temp = MyCart('a', 'b');
        temp.unconcatinatedstring(i);
        if (temp.productId == a.productId) {
          notAddedToCart = false;
          quantity = temp.quantity;
        }
      });
    }

    return Scaffold(
      body: Column(
        children: [
          Text("${temp.uid}"),
          Text("name= ${a.name}"),
          Text("price= ${a.price}"),
          Text("shopname= ${a.shopname}"),
          Text("Average Rating = ${a.averageRating}"),

          //fetch from reviews/a.productid/ all docs and show it. if doc[i]=temp.uid then store it as my comment.

          FutureBuilder(
              future: getallreviews(a),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Text("Loading");
                } else {
                  return Container(
                      height: 200,
                      width: 600,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 100,
                              width: 600,
                              child: Row(children: [
                                Text("${snapshot.data[index].uid}"),
                                Text("${snapshot.data[index].message}"),
                              ]),
                            );
                          }));
                }
              }),

          FutureBuilder(
              future: hascommented(a),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Text("Loading");
                } else {
                  if (snapshot.data.uid == "null") {
                    return Column(
                      children: [
                        TextField(
                          controller: mycontroller1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'give rating 1-5 here ',
                            hintText: 'Enter your rating here',
                          ),
                        ),
                        TextField(
                          controller: mycontroller2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Add review ',
                            hintText: 'Enter your review here',
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              Review newreview = Review();
                              newreview.newreview(temp.uid, mycontroller1.text,
                                  mycontroller2.text);
                              await newreview.savetodatabase(a.productId);
                            },
                            child: Text("Add review"))
                      ],
                    );
                  } else {
                    return Container(
                        height: 200,
                        width: 300,
                        child: Column(children: [
                          Text(
                              "Your previous rating is ${snapshot.data.rating} "),
                          TextField(
                            controller: mycontroller1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'give new rating 1-5 here ',
                              hintText: 'Enter your new rating here',
                            ),
                          ),
                          Text(
                              "Your previous review is ${snapshot.data.message} "),
                          TextField(
                            controller: mycontroller2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Add new review ',
                              hintText: 'Enter your new review here',
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                Review newreview = Review();
                                newreview.newreview(temp.uid,
                                    mycontroller1.text, mycontroller2.text);
                                await newreview.savetodatabase(a.productId);
                              },
                              child: Text("Edit review"))
                        ]));
                  }
                }
              }),

          notAddedToCart == true
              ? Container(
                  alignment: Alignment.topLeft,
                  height: 100,
                  width: 300,
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        width: 100,
                        child: TextField(
                          controller: mycontroller3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter quantity ',
                            hintText: 'Enter quantity here',
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            temp.addToMyCart(a.productId, mycontroller3.text);
                            await temp.modeltodatabase();
                          },
                          child: Text("Add to my cart"))
                    ],
                  ))
              : Container(
                  height: 50,
                  width: 100,
                  child: Row(
                    children: [
                      Text("already added with quantity ${quantity}"),
                      TextButton(
                          onPressed: () {}, child: Text("Removed from my cart"))
                    ],
                  ),
                ),

          //search if revies/a.productid/temp.uid doc exists of not
          //if exists display edit option, showing his review
        ],
      ),
    );
  }
}
