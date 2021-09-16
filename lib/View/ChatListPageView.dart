import 'package:flutter/material.dart';
import 'package:sochial_app/Global/Colors.dart' as MyColors;
import 'package:sochial_app/Global/Settings.dart' as Settings;
import 'package:sochial_app/Widget/ChatListViewItem.dart';

class ChatListPageView extends StatefulWidget {
  @override
  _ChatListPageViewState createState() => _ChatListPageViewState();
}

class _ChatListPageViewState extends State<ChatListPageView> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Center(child: CircularProgressIndicator(),) ;
    } else {
      return Container(
        child: Scaffold(
          backgroundColor: Settings.isDarkMode
                    ? Colors.grey[900] : MyColors.blue,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            centerTitle: true,
            title: Text(
              'chats',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Settings.isDarkMode
                  ? Icons.wb_sunny
                  : Icons.nightlight_round),
              onPressed: () {
                Settings.changeTheme();
              },
            ),
          ),
          body: Container(
            child: Container(
              decoration: BoxDecoration(
                color: Settings.isDarkMode
                    ? MyColors.darkBackGround
                    : MyColors.backGround,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: ListView(
                children: <Widget>[
                  // ChatListViewItem(
                  //   hasUnreadMessage: true,
                  //   image: AssetImage('assets/images/person1.jpg'),
                  //   lastMessage:
                  //       "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                  //   name: "Bree Jarvis",
                  //   newMesssageCount: 8,
                  //   time: "19:27 PM",
                  // ),

                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
