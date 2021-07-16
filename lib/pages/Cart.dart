import 'package:flutter/material.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/pages/Login.dart';
import 'package:foodmonkey/utils/Api.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: Constants.cartProducts.length,
                  itemBuilder: (context, index) =>
                      _buildCartProduct(Constants.cartProducts[index])),
            ),
            Container(
                height: 150,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Constants.accent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sub Total : ",
                            style: TextStyle(
                                color: Constants.primary,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        Text("${Constants.getCartTotal()} Ks",
                            style: TextStyle(
                                color: Constants.normal,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        onPressed: () async {
                          if (Constants.user == null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          } else {
                            bool bol = await Api.uploadOrder(
                                total: Constants.getCartTotal(),
                                items: Constants.generateOrder());

                            if (bol) {
                              Constants.cartProducts = [];
                              Navigator.pushNamed(context, "/home");
                            }
                          }
                        },
                        color: Constants.normal,
                        child: Text("Order Now",
                            style: TextStyle(
                                color: Constants.primary,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)))
                  ],
                ))
          ],
        ));
  }

  Widget _buildCartProduct(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Positioned(
              right: -8,
              top: -8,
              child: InkWell(
                onTap: () {
                  setState(() {
                    Constants.removeProduct(product);
                  });
                },
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Constants.accent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.clear, color: Constants.primary),
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Image.network(Constants.getImageLink(product.images?[0]),
                      width: 120, height: 120),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name ?? "",
                            style: Constants.getTitleTextStyle(25)),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Constants.normal,
                                        fontFamily: "English",
                                        fontSize: 16),
                                    children: [
                                  TextSpan(
                                      text: "Price ${product.price ?? 0}\n"),
                                  TextSpan(
                                      text:
                                          "Total ${(product.price ?? 0) * product.count}"),
                                ])),
                            SizedBox(width: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      Constants.reduceProductCount(product);
                                    });
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Constants.normal,
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.remove,
                                        size: 18, color: Constants.primary),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                      product.count.toString().padLeft(2, "0"),
                                      style: TextStyle(
                                          color: Constants.normal,
                                          fontSize: 22)),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      Constants.addProductCount(product);
                                    });
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Constants.normal,
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.add,
                                        size: 18, color: Constants.primary),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
