import 'package:flutter/material.dart';
import 'package:foodmonkey/helpers/TrianglePainer.dart';
import 'package:foodmonkey/pages/Register.dart';
import 'package:foodmonkey/utils/Api.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  var phoneController = TextEditingController(text: "09300300300");
  var passwordController = TextEditingController(text: "@123!Abc");
  @override
  Widget build(BuildContext context) {
    var msize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              CustomPaint(
                painter: TrianglePainter(msize),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Image.asset("assets/images/fm.png"),
                    Text("Login", style: Constants.getTitleTextStyle(40)),
                    SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                                labelText: "Phone",
                                labelStyle: TextStyle(
                                    color: Constants.normal, fontSize: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Constants.normal)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Constants.normal))),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    color: Constants.normal, fontSize: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Constants.normal)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Constants.normal))),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Text("Not a member yet! \n Register here!",
                              style: TextStyle(color: Colors.blue[400])),
                        ),
                        RaisedButton(
                            color: Constants.accent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            onPressed: () async {
                              var phone = phoneController.text;
                              var password = passwordController.text;

                              bool bol = await Api.loginUser(
                                  phone: phone, password: password);
                              if (bol) {
                                Constants.getSocket();
                                Navigator.pop(context);
                              } else {
                                print("Login Fail!");
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.lock, color: Constants.primary),
                                SizedBox(width: 20),
                                Text("Login",
                                    style: TextStyle(
                                        color: Constants.primary, fontSize: 20))
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
