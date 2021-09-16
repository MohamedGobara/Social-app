import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/cubit_login/login_cubit.dart';
import 'package:sochial_app/cubit_login/login_states.dart';
import 'package:sochial_app/cubit_home/home_cubit.dart';

class notifications extends StatefulWidget {
  @override
  _notificationsState createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => social_cubit(),
      child: BlocConsumer<social_cubit, social_states>(
        listener: (context, social_states) {},
        builder: (context, social_states) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                home_cubit.get(context).title[2],
                style: defaultthemeappbar,
              ),
            ),

            body: Center (

              child: Column (children: [


                Card(child: Image (image: AssetImage ("lib/my_images/undraw_Notify_re_65on.png"),) , clipBehavior: Clip.antiAliasWithSaveLayer,)
                , Text ("No notifications for yet!" , style: TextStyle (fontSize: 30 , color: Colors.blueGrey),)


              ],),

            ),

          );
        },
      ),
    );
  }
}
