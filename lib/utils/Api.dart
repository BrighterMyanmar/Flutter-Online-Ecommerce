import 'dart:convert';

import 'package:foodmonkey/models/Category.dart';
import 'package:foodmonkey/models/History.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/models/Tag.dart';
import 'package:foodmonkey/models/User.dart';
import 'package:foodmonkey/utils/Constants.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<bool> getApiVersion() async {
    Uri uri = Uri.parse("${Constants.API_URL}/appversion");
    print("Api Version");
    print(uri);
    var resStr = await http.get(uri);
    var response = jsonDecode(resStr.body);
    return Constants.API_VERSION == double.parse(response["result"]);
  }

  static Future<bool> getAllTags() async {
    Uri uri = Uri.parse("${Constants.API_URL}/tags");
    var resStr = await http.get(uri);
    var response = jsonDecode(resStr.body);
    var tList = response["result"] as List;
    Constants.tags = tList.map((tag) => Tag.fromJson(tag)).toList();
    return true;
  }

  static Future<bool> getAllCats() async {
    Uri uri = Uri.parse("${Constants.API_URL}/categories");
    var resStr = await http.get(uri);
    var response = jsonDecode(resStr.body);

    if (response["con"]) {
      var cList = response["result"] as List;
      Constants.cats = cList.map((cat) => Category.fromJson(cat)).toList();
    }

    return response["con"];
  }

  static Future<List<Product>> getPaginatedProducts(pageNo) async {
    Uri uri = Uri.parse("${Constants.API_URL}/products/$pageNo");
    var resStr = await http.get(uri);
    var response = jsonDecode(resStr.body);
    List<Product> products = [];
    if (response["con"]) {
      var pList = response["result"] as List;
      products = pList.map((p) => Product.fromJson(p)).toList();
    }
    return products;
  }

  static Future<bool> loginUser({phone, password}) async {
    Uri uri = Uri.parse("${Constants.BASE_URL}/user");
    var json = jsonEncode({"phone": phone, "password": password});
    var resStr = await http.post(uri, body: json, headers: Constants.headers);
    var responseData = jsonDecode(resStr.body);
    var usrData = responseData["result"];
    Constants.user = User.fromJson(usrData);
    return responseData["con"];
  }

  static Future<bool> registerUser({name, phone, password}) async {
    Uri uri = Uri.parse("${Constants.BASE_URL}/user/register");
    var json = jsonEncode({
      "name": name,
      "phone": phone,
      "email": "$name@email.com",
      "password": password
    });
    var resStr = await http.post(uri, body: json, headers: Constants.headers);
    print(resStr.body);
    var responseData = jsonDecode(resStr.body);
    return responseData["con"];
  }

  static Future<bool> uploadOrder({total, items}) async {
    var json = jsonEncode({'total': total, 'items': items});
    Uri uri = Uri.parse("${Constants.BASE_URL}/api/order");
    var response =
        await http.post(uri, body: json, headers: Constants.tokenHeader);
    var responseData = jsonDecode(response.body);
    print(responseData);
    return true;
  }

  static Future<List<History>> getMyOrders() async {
    Uri uri = Uri.parse("${Constants.API_URL}/userorder/${Constants.user?.id}");
    print(uri);
    var resStr = await http.get(uri);
    var response = jsonDecode(resStr.body);
    var rList = response["result"] as List;
    List<History> hl = rList.map((r) => History.fromJson(r)).toList();
    return hl;
  }
}
