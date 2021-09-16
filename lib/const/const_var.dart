import 'package:flutter/material.dart';
import 'package:sochial_app/shared/shared_pre.dart' ;

var const_user_data;

String const_email = CachHelper.getData(key: "email");

String const_username = CachHelper.getData(key: "name");

String const_bio = CachHelper.getData(key: "bio");

String const_phone = CachHelper.getData(key: "phone");

String const_uid = CachHelper.getData(key: "uid");
String saved_email = CachHelper.getData(key: "saved_email");
String saved_password = CachHelper.getData(key: "saved_email");

String const_token;

String const_link_image_profile = CachHelper.getData(key: "profilephoto");

String const_link_image_cover = CachHelper.getData(key: "coverphoto");
String const_post_image_link  ;

bool const_login_isclicked = false;

bool const_signup_isclicked = false;
bool const_isremeberme = false;





TextStyle defaultthemeappbar = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: "PlayfairDisplay");
