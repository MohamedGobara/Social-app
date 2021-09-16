import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/const/methods.dart';
import 'package:sochial_app/cubit_home/home_states.dart';
import 'package:sochial_app/cubit_login/login_cubit.dart';
import 'package:sochial_app/cubit_login/login_states.dart';
import 'package:sochial_app/cubit_home/home_cubit.dart';
import 'package:sochial_app/screens/chat_typing.dart';

class all_users extends StatefulWidget {
  @override
  _all_usersState createState() => _all_usersState();
}

class _all_usersState extends State<all_users> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => home_cubit()..get_allusers(),
      child: BlocConsumer<home_cubit, home_states>(
        listener: (context, home_states) {},
        builder: (context, home_states) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  home_cubit.get(context).title[1],
                  style: defaultthemeappbar,
                ),
              ),
              body: home_cubit.get(context).allusers == null
                  ? Center(child: Container())
                  : ListView.separated(
                      itemBuilder: (context, index) => Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){},
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                19,
                                          ),
                                          CircleAvatar(
                                            radius: 23,
                                            backgroundImage: home_cubit
                                                            .get(context)
                                                            .allusers[index]
                                                        ["image_profile"] ==
                                                    null
                                                ? AssetImage(
                                                    "lib/my_images/blank-profile-picture-973460_640.png")
                                                : NetworkImage(home_cubit
                                                        .get(context)
                                                        .allusers[index]
                                                    ["image_profile"]),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                19,
                                          ),
                                          Text(
                                            home_cubit
                                                .get(context)
                                                .allusers[index]["username"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(

                                    onTap: (){

                                      navpush(
                                          chat_typing(
                                              home_cubit.get(context).allusers,
                                              index),
                                          context);

                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.message_rounded,
                                            color: Colors.teal,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "Start Chat",
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: home_cubit.get(context).allusers.length));
        },
      ),
    );
  }
}
