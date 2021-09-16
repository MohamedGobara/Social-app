import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/const/methods.dart';
import 'package:sochial_app/cubit_login/login_states.dart';
import 'package:sochial_app/dio_helpers/dio.dart';
import 'package:sochial_app/screens/layout.dart';
import 'package:sochial_app/shared/shared_pre.dart';

class social_cubit extends Cubit<social_states> {
  social_cubit() : super(initializedstates());

  static social_cubit get(context) => BlocProvider.of(context);

  void signin({@required String email, @required String password, context}) {
    const_login_isclicked = true;

    emit(withingsignin());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      const_user_data = value.user;
      const_email = value.user.email;
      const_uid = value.user.uid;
      await CachHelper.setData(key: "uid", value: "${value.user.uid}");
      await CachHelper.setData(key: "saved_email", value: "${email}");
      await CachHelper.setData(key: "saved_password", value: "${password}");

     await  FirebaseFirestore.instance
          .collection("users")
          .doc(value.user.uid)
          .get()
          .then((value) async {
        //const_username = await value.data()["username"];
        // const_bio = await value.data()["bio"];
        // const_image_profile = await value.data()["image_profile"];
        // const_image_cover = await value.data()["image_cover"];


       await CachHelper.setData(key: "name", value: "${value.data()["username"]}");
        await CachHelper.setData(key: "email", value:"${value.data()["email"]}");
        await CachHelper.setData(key: "bio", value: "${value.data()["bio"]}");
        await CachHelper.setData(key: "phone", value: "${value.data()["phone"]}");


        if(value.data()["image_profile"]!=null ) { await CachHelper.setData(key: "profilephoto", value: "${value.data()["image_profile"]}");}
        if(value.data()["image_profile"]!=null ) {   await CachHelper.setData(key: "coverphoto", value: "${value.data()["image_cover"]}");}


        await CachHelper.setData(key: "rememberme", value: const_isremeberme);
        emit(successsignin());


        emit(successsignin());
      }).catchError((error) {
        print(error.toString());
      }).then((value) async {



     });
      print(value.user.uid);
      print("Login succsfuly");

      emit(successsignin());
    }).catchError((error) {
      print(error.toString());
      emit(errorsignin());
    }).then((value) {
      {
        if (const_user_data == null) {
          const_login_isclicked = false;
          print(value.toString() + "in sign in");

          emit(login_firebaseExaption_state());
        }
      }
    });
  }

  void signup(
      {@required String email,
      @required String password,
      @required String username,
      @required String phone,
      String profile_image,
      String profile_cover_image,
      String bio,
      bool ifverification = false,
      context}) {
    const_signup_isclicked = true;
    emit(withingsignup());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      const_user_data = value.user;
      const_email = value.user.email;
      const_phone = phone;
      const_username = username;

      FirebaseFirestore.instance.collection("users").doc(value.user.uid).set({
        "email": email,
        "password": password,
        "username": username,
        "phone": phone,
        "bio": bio,
        "image_profile": const_link_image_profile,
        "image_cover": const_link_image_cover,
        "verification": false
      });

      //value.user.sendEmailVerification() ;
      print("email :" + const_email);
      print("phone :" + const_phone);
      const_uid = value.user.uid;
      print("uid :" + value.user.uid);
      // print("cover :" +image_cover);
      // print("picture :" +image_profile.toString()) ;
      print("account created");

      emit(successsignup());
    }).catchError((error) {
      print(error.toString());
      emit(errorsignup());
    }).then((value) {
      if (const_user_data == null) {
        const_signup_isclicked = false;
        print(value.toString() + "in sign up");

        emit(signup_firebaseExaption_state());
      }
    });
  }
}
