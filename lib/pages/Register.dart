import 'package:flutter/material.dart';
import 'package:foodmonkey/helpers/TrianglePainer.dart';
import 'package:foodmonkey/utils/Api.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var msize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
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
                    SizedBox(height: 10),
                    Image.asset("assets/images/fm.png"),
                    Text("Register", style: Constants.getTitleTextStyle(40)),
                    SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                            color: Constants.accent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            onPressed: () async {
                              var name = nameController.text;
                              var phone = phoneController.text;
                              var password = passwordController.text;

                              bool bol = await Api.registerUser(
                                  name: name, phone: phone, password: password);
                              if (bol) {
                                Navigator.pop(context);
                              } else {
                                print("Registeration Fail!");
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.person, color: Constants.primary),
                                SizedBox(width: 20),
                                Text("Register",
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
