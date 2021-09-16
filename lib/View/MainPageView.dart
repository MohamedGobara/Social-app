import 'package:flutter/material.dart';
import 'package:sochial_app/View/ChatListPageView.dart';
import 'package:sochial_app/View/ChatPageView.dart';

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 750) {
      return ChatListPageView();
    } else {
      return Scaffold(
        body: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: ChatListPageView(),
            ),
            VerticalDivider(width: 2,),
            Expanded(
              child: ChatPageView(
                username: 'test',
              ),
            )
          ],
        ),
      );
    }
  }
}
