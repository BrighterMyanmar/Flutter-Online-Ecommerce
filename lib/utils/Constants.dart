import 'package:flutter/material.dart';
import 'package:foodmonkey/models/Category.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/models/Tag.dart';
import 'package:foodmonkey/models/User.dart';
import 'package:foodmonkey/pages/Cart.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Constants {
  static const Color primary = Color(0xFFF6F6F6);
  static const Color secondary = Color(0xFFFFBB91);
  static const Color accent = Color(0xFFFF8E6E);
  static const Color normal = Color(0xFF515070);

  static const Color yellow = Color(0xffFDC054);
  static const Color darkGrey = Color(0xff202020);
  static const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);

  static const double API_VERSION = 1.0;
  static User? user;

  static const String BASE_URL = "http://10.0.2.2:3000";
  static String SOCKET_END_POINT = "$BASE_URL/chat?token=${user?.token}";
  static const String API_URL = "$BASE_URL/api";
  static const String GALLERY_URL = "$BASE_URL/gallery";
  static const String shopId = "605c19163bac7310fb16aabc";

  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Map<String, String> tokenHeader = {
    'Content-type': 'application/json',
    'authorization': 'Bearea ${user?.token}'
  };

  static const String sampleText = """
    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nam cupiditate vel accusamus tenetur veniam non soluta quas quidem! Unde officia modi inventore ducimus blanditiis quaerat consequatur nesciunt repudiandae, cum nihil.
   """;
  static const String sampleImage =
      "http://192.168.8.100:3000/uploads/8_1616675537280.png";

  static List<Tag> tags = [];
  static List<Category> cats = [];

  static IO.Socket? socket;

  static getSocket() {
    socket = IO.io(SOCKET_END_POINT, <String, dynamic>{
      'transports': ['websocket']
    });
    socket?.onConnect((_) {
      print("Connected");
    });
  }

  static String getImageLink(image) {
    var img = "http://192.168.8.100:3000/uploads" + image.split("uploads")[1];
    return img;
  }

  static TextStyle getTitleTextStyle(double size) {
    return TextStyle(
        color: Constants.normal, fontSize: size, fontWeight: FontWeight.bold);
  }

  static List<List<String>> orders = [
    ["Order One", "Order One", "Order One"],
    ["Order Two", "Order Two", "Order Two", "Order Two", "Order Two"],
    ["Order Three", "Order Three"]
  ];

  static List<Product> cartProducts = [];

  static addToCart(product) {
    bool exist = false;
    if (cartProducts.length > 0) {
      cartProducts.forEach((prod) {
        print(prod.id);
        if (prod.id == product.id) {
          prod.count++;
          exist = true;
        }
      });
      if (!exist) {
        cartProducts.add(product);
      }
    } else {
      cartProducts.add(product);
    }
  }

  static generateOrder() {
    List<Map> cartList = [];
    cartProducts.forEach((prod) {
      var map = new Map();
      map["count"] = prod.count.toString();
      map["productId"] = prod.id;
      cartList.add(map);
    });
    return cartList;
  }

  static removeProduct(product) {
    cartProducts.removeWhere((prds) => prds.id == product.id);
  }

  static addProductCount(product) {
    cartProducts.forEach((prd) {
      if (prd.id == product.id) {
        prd.count++;
      }
    });
  }

  static reduceProductCount(product) {
    cartProducts.forEach((prd) {
      if (prd.id == product.id) {
        if (prd.count > 1) {
          prd.count--;
        }
      }
    });
  }

  static int getCartTotal() {
    int total = 0;
    cartProducts.forEach((p) {
      total += p.count * int.parse(p.price.toString());
    });
    return total;
  }

  static Padding getCartAction(context, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
              child: Icon(Icons.shopping_cart, size: 40, color: color)),
          Positioned(
            right: 0,
            top: -5,
            child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Text(Constants.cartProducts.length.toString(),
                        style: TextStyle(color: Constants.primary)))),
          )
        ],
      ),
    );
  }
}
