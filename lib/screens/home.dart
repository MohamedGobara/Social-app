import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/const/methods.dart';
import 'package:sochial_app/cubit_home/home_cubit.dart';
import 'package:sochial_app/cubit_home/home_states.dart';
import 'package:sochial_app/screens/post.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  bool isgetpost = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => home_cubit()..getpost(),
      child: BlocConsumer<home_cubit, home_states>(
        listener: (context, home_states) {},
        builder: (context, home_states) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                home_cubit.get(context).title[0],
                style: defaultthemeappbar,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {




                      home_cubit.get(context).get_allusers() ;


                    },
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        image: NetworkImage(
                          "https://www.socialchangecentral.com/wp-content/uploads/2021/04/3-Steps-to-Engaging-Others-in-Your-Social-Change-Mission.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    IntrinsicHeight(
                      child: Container(
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // navpushreplas(profile(), context ) ;
                                          },
                                          child: CircleAvatar(
                                            radius: 17,
                                            backgroundImage:
                                                const_link_image_profile == null
                                                    ? AssetImage(
                                                        "lib/my_images/blank-profile-picture-973460_640.png")
                                                    : NetworkImage(
                                                        const_link_image_profile),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            navpush(post(), context);
                                          },
                                          child: Container(
                                            height: 45,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.3,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.blueGrey,
                                                    width: 1)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "What's on your mind?",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.blueGrey,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Live",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Icon(
                                              Icons.video_call_outlined,
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Photo",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Icon(
                                              Icons.photo_album_outlined,
                                              color: Colors.teal,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                print(home_cubit
                                                    .get(context)
                                                    .mygetposts
                                                    .length);
                                              },
                                              child: Text(
                                                "Room",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Icon(
                                              Icons.roofing,
                                              color: Colors.indigoAccent,
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ConditionalBuilder(
                        condition:
                            home_cubit.get(context).mygetposts.length != null,
                        builder: (context) => ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => new_posts(
                                home_cubit.get(context).mygetposts,
                                index,
                                context,
                                home_cubit.get(context).post_id),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount:
                            home_cubit.get(context).mygetposts.length) ,
                        fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
