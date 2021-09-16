import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/cubit_home/home_cubit.dart';
import 'package:sochial_app/cubit_home/home_states.dart';
import 'package:intl/intl.dart';

class post extends StatefulWidget {
  @override
  _postState createState() => _postState();
}

class _postState extends State<post> {
  var date_now = DateFormat(' h:mm a yy-M-d  ').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    TextEditingController mypots = TextEditingController();
    return BlocProvider(
      create: (context) => home_cubit(),
      child: BlocConsumer<home_cubit, home_states>(
        listener: (context, home_states)

        {







          if(home_states is successpostsent) {

            Fluttertoast.showToast(
                msg: "Posted successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );



          }


        },
        builder: (context, home_states) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Create post",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Post",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (mypots.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(''),
                                    content: Text("Can't post an empty post"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Ok')),
                                    ],
                                  );
                                });
                          } else {
                            home_cubit.get(context).sentpost(
                                link_profile_image: const_link_image_profile,
                                text_post: mypots.text,
                                date: date_now,
                                username: const_username);

                            print(const_link_image_profile);
                          }
                        }))
              ],
            ),
            body: Container(
              color: Colors.white,
              height: 900,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    if (home_states is withingpostsent)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: const_link_image_profile == null
                              ? AssetImage(
                                  "lib/my_images/blank-profile-picture-973460_640.png")
                              : NetworkImage(const_link_image_profile),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text("$const_username",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "What's on your mind?",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        controller: mypots,
                      ),
                    )
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
