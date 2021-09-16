import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/const/methods.dart';
import 'package:sochial_app/cubit_home/home_states.dart';
import 'package:sochial_app/icons/my_flutter_app_icons.dart';
import 'package:sochial_app/screens/editprofile.dart';
import 'package:sochial_app/cubit_home/home_cubit.dart';
import 'package:sochial_app/screens/login.dart';
import 'package:sochial_app/shared/shared_pre.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => home_cubit(),
      child: BlocConsumer<home_cubit, home_states>(
        listener: (context, home_states) {},
        builder: (context, home_states) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                home_cubit.get(context).title[3],
                style: defaultthemeappbar,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      navpushreplas(login(), context);

                      CachHelper.romoveData(key: "email");

                      CachHelper.romoveData(key: "name");

                      CachHelper.romoveData(key: "bio");

                      CachHelper.romoveData(key: "phone");

                      CachHelper.romoveData(key: "uid");
                      CachHelper.romoveData(key: "saved_email");
                      CachHelper.romoveData(key: "saved_email");

                      CachHelper.romoveData(key: "profilephoto");

                      CachHelper.romoveData(key: "coverphoto");

                      CachHelper.setData(key: "rememberme" , value: false);
                      FirebaseAuth.instance.signOut().then((value) {
                        print("logut succeful ");
                      }).catchError((error) {
                        print(error.toString());
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height/2.5,
                    child: Stack(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image(
                            image: const_link_image_cover == null
                                ? AssetImage(
                                    "lib/my_images/blank-profile-picture-973460_640.png")
                                : NetworkImage(const_link_image_cover),
                            // height: 190,
                            // width: 410,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width / 1.9),
                            Center(
                              child: CircleAvatar(
                                backgroundImage: const_link_image_profile ==
                                        null
                                    ? AssetImage(
                                        "lib/my_images/blank-profile-picture-973460_640.png")
                                    : NetworkImage(const_link_image_profile),
                                radius: 50,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    if (const_username != null)
                                      Text(
                                        const_username,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (const_bio != null)
                                  Text(const_bio,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.teal))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                              width: MediaQuery.of(context).size.width / 18,
                            )),
                            Column(
                              children: [
                                SizedBox(
                                  width: 90,
                                ),
                                Text("0",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("posts",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                            Expanded(
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        18)),
                            Column(
                              children: [
                                Text("0",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("photos",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                            Expanded(
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        18)),
                            Column(
                              children: [
                                Text("0",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("followers",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                            Expanded(
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        18)),
                            Column(
                              children: [
                                Text("0",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("following",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                            Expanded(
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        18)),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Add photo",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(MyFlutterApp.camera)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 20,
                            ),
                            InkWell(
                              onTap: () {
                                navpush(edit_profile(), context);
                              },
                              child: Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width / 5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        MyFlutterApp.pencil,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
