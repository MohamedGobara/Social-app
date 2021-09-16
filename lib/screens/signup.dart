import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/const/methods.dart';
import 'package:sochial_app/cubit_login/login_cubit.dart';
import 'package:sochial_app/cubit_login/login_states.dart';

import 'package:sochial_app/screens/layout.dart';
import 'package:sochial_app/screens/login.dart';

class signup extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<signup> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  var usernamecontroller = TextEditingController();
  var myformkey = GlobalKey<FormState>();
  bool isvisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => social_cubit(),
      child: BlocConsumer<social_cubit, social_states>(
        listener: (context, social_states) {
          if (social_states is successsignup) {
            Fluttertoast.showToast(
                msg: "Account Created successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 4,
                backgroundColor: Colors.greenAccent,
                textColor: Colors.white,
                fontSize: 16.0);
            navpushreplas(layout(), context);
          }

          if (social_states is signup_firebaseExaption_state) {
            Fluttertoast.showToast(
                msg: "Data error Check the entered data",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 4,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, social_states) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: myformkey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            //clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [BoxShadow(color: Colors.white)]),
                              child: Image(
                                image: AssetImage(
                                  "lib/my_images/sign_up.png",
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,

                              // fontFamily:
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: usernamecontroller,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "user name must not be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "Enter your name",
                              labelText: "User name",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent, width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: emailcontroller,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Email must not be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Enter your email",
                              labelText: "Email",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent, width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: passwordcontroller,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Password must not be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.security),
                                hintText: "Enter your password",
                                labelText: "Password",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(15)),
                                suffixIcon: IconButton(
                                  icon: isvisible
                                      ? Icon(
                                          Icons.visibility_outlined,
                                          color: Colors.black45,
                                        )
                                      : Icon(
                                          Icons.visibility_off_outlined,
                                          color: Colors.deepOrangeAccent,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      isvisible = !isvisible;
                                    });
                                  },
                                )),
                            obscureText: isvisible,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: phonecontroller,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "phone must not be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              hintText: "Enter your phone",
                              labelText: "Phone",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent, width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition:
                            const_signup_isclicked !=
                                    true,
                            builder: (context) => SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                onPressed: () async {
                                  if (myformkey.currentState.validate()) {
                                    social_cubit.get(context).signup(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text,
                                        phone: phonecontroller.text,
                                        username: usernamecontroller.text,
                                        ifverification: false);
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                    elevation:
                                        MaterialStateProperty.all<double>(15),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.blue)),
                                    )),
                              ),
                            ),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      navpushreplas(login(), context);
                                    },
                                    child: Center(
                                      child: Text(
                                        "Already have an account",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
