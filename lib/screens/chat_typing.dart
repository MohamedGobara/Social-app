import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sochial_app/Widget/ReceivedMessageWidget.dart';
import 'package:sochial_app/Widget/SendedMessageWidget.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/cubit_home/home_cubit.dart';
import 'package:sochial_app/cubit_home/home_states.dart';

class chat_typing extends StatefulWidget {

  int index  ;
  List poersn ;
  chat_typing(this.poersn , this.index) ;

  @override
  _chat_typingState createState() => _chat_typingState();
}

class _chat_typingState extends State<chat_typing> {
  TextEditingController mycontroller = new TextEditingController();
  ScrollController _scrollController = ScrollController();
  var saved_message;

  @override
  Widget build(BuildContext context) {
    var mymedia_width = MediaQuery.of(context).size.width;
    var mymedia_heigth = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => home_cubit()..get_message(recivedid: widget.poersn , index: widget.index),
      child: BlocConsumer<home_cubit, home_states>(
        listener: (context, home_states) {},
        builder: (context, home_states) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: Text(
                 widget.poersn[widget.index]["username"],
                  style: TextStyle(color: Colors.black),
                ),
                leading: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: widget.poersn[widget.index]["image_profile"] ==null
                          ? AssetImage(
                              "lib/my_images/blank-profile-picture-973460_640.png")
                          :NetworkImage (widget.poersn[widget.index]["image_profile"]) ,
                    ),
                  ],
                ),
                leadingWidth: 90,
                titleSpacing: 10
                //,
                ),
            body: StreamBuilder (builder: (context , snapshot) {

              return Container(
                width: mymedia_width,
                height: mymedia_heigth,
                child: Column(children: [
                  Expanded(
                      child: home_cubit.get(context).message.isEmpty?Container() : ListView.builder(
                        reverse: true,
                        itemBuilder: (context, index) => home_cubit
                            .get(context)
                            .message[index]["my_id"] ==
                            const_uid
                            ? SendedMessageWidget(
                          content: home_cubit.get(context).message[index]
                          ["text"],
                          time: home_cubit.get(context).message[index]["date"],
                          isImage: false,
                        )
                            : ReceivedMessageWidget(
                          content: home_cubit.get(context).message[index]
                          ["text"],
                          time: home_cubit.get(context).message[index]["date"],
                          isImage: false,
                        ),
                        itemCount: home_cubit.get(context).message.length,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter your message...",
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send_rounded,
                              color: Colors.greenAccent,
                            ),
                            onPressed: () {
                              home_cubit.get(context).sent_message(
                                  revised_uid: widget.poersn[widget.index]["uid"],
                                  date: DateTime.now().toString(),
                                  text: mycontroller.text);

                              mycontroller.text = "";
                            },
                          )  ,
                          enabledBorder: OutlineInputBorder (

                              borderRadius: BorderRadius.circular(10)


                          )


                      ),
                      validator: (value) {
                        return "message must not be empty";
                      },
                      controller: mycontroller,
                      onSaved: (value) {
                        saved_message = value;
                      },
                    ),
                  )
                ]),
              ) ;


            }, stream: home_cubit.get(context).get_message(recivedid: widget.poersn , index: widget.index),)
          );
        },
      ),
    );
  }
}
