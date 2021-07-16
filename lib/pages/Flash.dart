import 'package:flutter/material.dart';
import 'package:foodmonkey/helpers/TrianglePainer.dart';
import 'package:foodmonkey/utils/Api.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Flash extends StatefulWidget {
  const Flash({Key? key}) : super(key: key);

  @override
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  void appVersionCheck() async {
    bool passedApiCheck = await Api.getApiVersion();
    bool passedTagCheck = await Api.getAllTags();
    bool passedCatCheck = await Api.getAllCats();

    if (passedApiCheck && passedTagCheck && passedCatCheck) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      print("Api Version Problem");
    }
  }

  @override
  void initState() {
    super.initState();
    appVersionCheck();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          CustomPaint(
            painter: TrianglePainter(size),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Food Monkey",
                    style: TextStyle(
                        color: Constants.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 45)),
              ),
              SizedBox(height: 60),
              Center(child: Image.asset("assets/images/fm.png")),
              SizedBox(height: 60),
              Center(
                  child: CircularProgressIndicator(
                backgroundColor: Constants.accent,
                valueColor: AlwaysStoppedAnimation(Constants.normal),
              ))
            ],
          )
        ],
      ),
    ));
  }
}
