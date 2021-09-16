import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/cubit_home/home_cubit.dart';
import 'package:sochial_app/cubit_home/home_states.dart';
import 'package:sochial_app/icons/MyIcons.dart';


class layout extends StatefulWidget {
  @override
  _layoutState createState() => _layoutState();
}

class _layoutState extends State<layout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => home_cubit(),
      child: BlocConsumer<home_cubit, home_states>(
        listener: (context, states) {},
        builder: (context, states) {
          return Scaffold(
            body:
                home_cubit.get(context).screens[home_cubit.get(context).index],
            bottomNavigationBar: CurvedNavigationBar(
              height: 50,
              animationDuration: Duration(milliseconds: 410),
              items: [
                Icon(
                  MyIcons.home,
                ),
                Icon(
                  MyIcons.user_friends,
                ),

                Icon(
                  Icons.notifications,
                ),
                Icon(
                  Icons.account_circle_sharp,
                ),
              ],
              color: Colors.blue,
              backgroundColor: Colors.white,
              buttonBackgroundColor: Colors.white,
              index: home_cubit.get(context).index,
              onTap: (index) {
                setState(() {
                  home_cubit.get(context).changed(index);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
