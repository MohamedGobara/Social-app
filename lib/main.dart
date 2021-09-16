import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/screens/chat_typing.dart';
import 'package:sochial_app/screens/layout.dart';
import 'package:sochial_app/screens/login.dart';
import 'package:sochial_app/screens/splashscreen.dart';
import 'package:sochial_app/shared/shared_pre.dart';
import 'View/MainPageView.dart';
import 'cubit_home/home_cubit.dart';
import 'cubit_home/home_states.dart';
import 'cubit_login/login_cubit.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CachHelper.init();

  bool remmeber = await CachHelper.getData(key: "rememberme");

  Widget mywidget;
  if (remmeber == null) {
    mywidget = login();
  } else {
    if (remmeber == true) {
      mywidget = layout();
    } else {
      mywidget = login();
    }
  }
  runApp(MyApp(mywidget));
}

class MyApp extends StatelessWidget {
  Widget widg;

  MyApp(this.widg);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => social_cubit()
       // ..signin(email: saved_email, password: saved_password)
        ),
        BlocProvider(create: (context) => home_cubit()),
      ],
      child: BlocConsumer<home_cubit, home_states>(
        listener: (context, home_states)  {
          // if (home_states  is successupdateprofile) {
          //
          // await   social_cubit.get(context).signin(email: saved_email, password: saved_password) ;
          // print("autommtic login succeful ") ;
          // print("saved email : $saved_email    +    saved password : $saved_password")  ;
          //
          // }
        },
        builder: (context, social_states) {
          return MaterialApp(
            theme: ThemeData(
                appBarTheme: AppBarTheme(
                    titleSpacing: 15,
                    backgroundColor: Colors.white,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white,
                      systemNavigationBarColor: Colors.white,
                    ),
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.black)),
                scaffoldBackgroundColor: Colors.white60.withOpacity(0.9)),
            home: setCustomSplash(firsthome: widg),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
