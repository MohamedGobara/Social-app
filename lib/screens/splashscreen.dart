import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';

Widget setCustomSplash({@required Widget firsthome}) =>
    CustomSplash(
      imagePath: 'lib/my_images/—Pngtree—social network_5413579.png',
      backGroundColor: Colors.lightBlueAccent,
      animationEffect: 'fade-in',
      logoSize: 200,
      duration: 3000,
      type: CustomSplashType.StaticDuration,
      home: firsthome,

    );