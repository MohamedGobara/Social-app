import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sochial_app/const/Api_get_posts.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/cubit_home/home_cubit.dart';
import 'package:sochial_app/icons/MyIcons.dart';

void navpush(Widget mywidget, context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => mywidget));
}

void navpushreplas(Widget mywidget, context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => mywidget));
}

void pop(Widget mywidget, context) {
  Navigator.pop(context, MaterialPageRoute(builder: (context) => mywidget));
}

bool is_liked = true;

Widget backAppBar(
        {@required String title,
        List<Widget> action,
        Icons leadingIcon,
        context}) =>
    AppBar(
      title: Text(
        "$title",
        style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: "PlayfairDisplay"),
      ),
      actions: action,
      leading: IconButton(
        icon: leadingIcon == null
            ? Icon(Icons.arrow_back_ios_rounded)
            : leadingIcon,
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 3,
    );

Widget defaultTextField(
        {String hinttext,
        String labeltext,
        dynamic prfixicon,
        dynamic suffixicon,
        Function ontap,
        Function oncahnged,
        TextEditingController texteditingcontroller,
        TextInputType keypboardtybe,
        Function valdiate,
        bool ispassword = false,
        bool isenableld = true}) =>
    TextFormField(
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(
              color: Colors.blueGrey,
              fontSize: 14,
              fontWeight: FontWeight.w500),
          labelText: labeltext,
          labelStyle: TextStyle(
              color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
          prefixIcon: Icon(prfixicon),
          suffixIcon: Icon(suffixicon),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
              borderRadius: BorderRadius.circular(15))),
      onTap: ontap,
      onChanged: oncahnged,
      controller: texteditingcontroller,
      keyboardType: keypboardtybe,
      validator: valdiate,
      obscureText: ispassword,
      enabled: isenableld,
    );

Widget new_posts(List mylist, int index, context, List id_post) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: IntrinsicHeight(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 27,
                        backgroundImage: mylist[index]["profile_image"] == null
                            ? AssetImage(
                                "lib/my_images/blank-profile-picture-973460_640.png")
                            : NetworkImage(mylist[index]["profile_image"]),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (mylist[index]["user_name"] != null)
                              Text(
                                mylist[index]["user_name"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "PlayfairDisplay",
                                    fontWeight: FontWeight.bold),
                              ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          mylist[index]["date"],
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.more_horiz_rounded),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        mylist[index]["text_post"],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 30,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    IconButton(
                      icon: Icon(
                        MyIcons.heart,
                      ),
                      color:
                          // is_liked
                          //
                          //     ? Colors.grey :
                          //

                          Colors.red,
                      onPressed: () {
                        home_cubit
                            .get(context)
                            .setlike(id_post[index], const_uid);
                      },
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                          home_cubit.get(context).count_like == null
                              ? ""
                              : "${home_cubit.get(context).count_like}",
                          style: TextStyle(
                              color:

                                  // mylist[index]["likes"] == 0
                                  //     ? Colors.grey
                                  //     :

                                  Colors.black54)),
                    ),
                    Expanded(child: SizedBox(width:0 ,)) ,
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            MyIcons.comment,
                          ),
                          color: Colors.yellow,
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("posts")
                                .get()
                                .then((value) {
                              print(value.size.toString());
                            }).catchError((error) {});
                          },
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text("${mylist[index]["likes"]} comment",
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: const_link_image_profile == null
                          ? AssetImage(
                              "lib/my_images/blank-profile-picture-973460_640.png")
                          : NetworkImage(const_link_image_profile),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Write a comment.......",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
