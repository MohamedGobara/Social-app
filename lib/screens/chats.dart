import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/Widget/ChatListViewItem.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/cubit_home/home_cubit.dart';
import 'package:sochial_app/cubit_home/home_states.dart';

class chats extends StatefulWidget {
  @override
  _chatsState createState() => _chatsState();
}

class _chatsState extends State<chats> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => home_cubit()..get_user_conversation(),
      child: BlocConsumer<home_cubit, home_states>(
        listener: (context, home_states) {},
        builder: (context, home_states) => Scaffold(
            appBar: AppBar(
              title: Text(home_cubit.get(context).title[2],
                  style: defaultthemeappbar),
            ),
            body: Container ()

            // ConditionalBuilder(
            //   condition: home_cubit.get(context).list_conversation.length != null,
            //   builder: (context) => ListView.separated(
            //       itemBuilder: (context, index) => ChatListViewItem(
            //             hasUnreadMessage: true,
            //             image: home_cubit.get(context).list_conversation[index]
            //                 ["image"],
            //             lastMessage: home_cubit
            //                 .get(context)
            //                 .list_conversation[index]["last_message"],
            //             name: home_cubit.get(context).list_conversation[index]
            //                 ["name"],
            //             newMesssageCount: home_cubit
            //                 .get(context)
            //                 .list_conversation[index]["new_message"],
            //             time: home_cubit.get(context).list_conversation[index]
            //                 ["date"],
            //           ),
            //       separatorBuilder: (context, index) => Divider(),
            //       itemCount: home_cubit.get(context).list_conversation.length),
            //   fallback: (context) => Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // )
    ),
      ),
    );
  }
}
