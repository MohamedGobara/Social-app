import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/const/methods.dart';
import 'package:sochial_app/cubit_login/login_cubit.dart';
import 'package:sochial_app/cubit_login/login_states.dart';
import 'package:sochial_app/screens/layout.dart';
import 'package:sochial_app/screens/signup.dart';

class login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<login> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();
  var myformkey = GlobalKey<FormState>();
  bool isvisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => social_cubit(),
      child: BlocConsumer<social_cubit, social_states>(
        listener: (context, social_states) {
          if (social_states is successsignin) {
            navpushreplas(layout(), context);

            Fluttertoast.showToast(
              msg: "You are logged in successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          if (social_states is login_firebaseExaption_state) {
            Fluttertoast.showToast(
                msg: "Incorrect data entered",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 4,
                backgroundColor: Colors.greenAccent,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, social_states) {
          return Scaffold(
              appBar: AppBar(),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: myformkey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
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
                                  "lib/my_images/undraw_Login_re_4vu2.png",
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Text(
                            "Login",
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
                                hintText: "Enter yor password",
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
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ), //SizedBox
                              Text(
                                'Remember me',
                                style: TextStyle(fontSize: 17.0),
                              ), //Text
                              SizedBox(width: 10), //SizedBox
                              Checkbox(
                                value: const_isremeberme,
                                onChanged: (bool value) {
                                  setState(() {

                                    const_isremeberme=!const_isremeberme  ;

                                  });
                                },
                              ), //Checkbox
                            ], //<Widget>[]
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                            builder: (context) => SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                onPressed: () async {
                                  if (myformkey.currentState.validate()) {
                                    social_cubit.get(context).signin(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text);

                                    // if (social_cubit.get(context).login_uid != null) {
                                    //   print("get id successful");
                                    //
                                    //   navpushreplas(layout(), context);
                                    // }
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    "Login",
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
                            condition: const_login_isclicked == false,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                TextButton(
                                    onPressed: () {
                                      navpushreplas(signup(), context);
                                    },
                                    child: Text("You can register now")),
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
