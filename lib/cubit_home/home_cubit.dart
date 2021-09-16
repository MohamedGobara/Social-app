import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sochial_app/const/Api_get_posts.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/cubit_home/home_states.dart';
import 'package:sochial_app/icons/MyIcons.dart';
import 'package:sochial_app/icons/my_flutter_app_icons.dart';
import 'package:sochial_app/screens/chats.dart';
import 'package:sochial_app/screens/all_users.dart';
import 'package:sochial_app/screens/home.dart';
import 'package:sochial_app/screens/notifications.dart';
import 'package:sochial_app/screens/profile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sochial_app/shared/shared_pre.dart';

class home_cubit extends Cubit<home_states> {
  home_cubit() : super(initializedstates());

  static home_cubit get(context) => BlocProvider.of(context);
  File profile_image;
  File pofile_cover_image;

  File post_image;

  int index = 0;
  List screens = [home(), all_users(),notifications(), profile()];
  List title = ["Home", "All users",
    "Notifications", "Profile"];

  void changed(int n) {
    index = n;
  }

  void getprofileImage() async {
    emit(withingloadprofileimmage());
    final pickedfile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      profile_image = File(pickedfile.path);
      emit(successsloadprofileimmage());
    } else {
      print("No image selected");
      emit(errorloadprofileimmage());
    }
  }

  void getprofilecoverImage() async {
    emit(withingloadprofilecoverimmage());
    final pickedfile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      pofile_cover_image = File(pickedfile.path);
      emit(successsloadprofilecoverimmage());
    } else {
      print("No image selected");
      emit(errorloadprofilecoverimmage());
    }
  }

  void uploadprofileImage() async {
    print("start upload profile image...");
    emit(withinghangeprofileimmage());

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profile_image.path).pathSegments.last} ")
        .putFile(profile_image)
        .then((value) {
      print("success upload profile image");

      value.ref.getDownloadURL().then((value) async {
        const_link_image_profile = await value.toString();

        print(value.toString());

        print("get image link success");
        emit(successschangeprofileimmage());
      }).catchError((error) {
        print(error.toString());

        emit(errochangeprofileimmage());
      });
    }).catchError((error) {
      print(error.toString());

      emit(errochangeprofileimmage());
    });
  }

  void uploadprofilecoverImage() async {
    print("start upload cover image...");
    emit(withinghangeprofilecoverimmage());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(pofile_cover_image.path).pathSegments.last} ")
        .putFile(pofile_cover_image)
        .then((value) {
      print("success upload cover image...");

      value.ref.getDownloadURL().then((value) async {
        const_link_image_cover = await value.toString();
        print(value.toString());
        print("get cover image link success");

        emit(successschangeprofilecoverimmage());
      }).catchError((error) {
        print(error.toString());

        emit(errochangeprofilecoverimmage());
      });
    }).catchError((error) {
      print(error.toString());

      emit(errochangeprofilecoverimmage());
    });
  }

  void updateprofiledata(
      {String bio_update,
      String image_cover_update,
      String image_profile_update,
      String name_update}) {
    emit(withingupdateprofile());

    FirebaseFirestore.instance.collection("users").doc(const_uid).update({
      // bio_update != null ??
      "bio": bio_update,
      // image_cover_update != null ?? " "
      "image_cover": image_cover_update,
      //  image_profile_update != null ??
      "image_profile": image_profile_update,
      //name_update != null ??
      "username": name_update,
    }).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(const_uid)
          .get()
          .then((value) async {
        //  name_update != null ??
        await CachHelper.setData(
            key: "name", value: "${value.data()["username"]}");
        //bio_update != null ??
        await CachHelper.setData(key: "bio", value: "${value.data()["bio"]}");

        if (value.data()["image_cover"] != null) {
          //   image_profile_update != null ??
          await CachHelper.setData(
              key: "profilephoto", value: "${value.data()["image_profile"]}");
        }
        if (value.data()["image_profile"] != null) {
          // image_cover_update != null ??
          await CachHelper.setData(
              key: "coverphoto", value: "${value.data()["image_cover"]}");
        }

        print("Cach new data is updated");

        emit(successupdateprofile());
      }).catchError((error) {
        print(error.toString());
        emit(errorupdateprofile());
      });

      print("profile is updated ");
      emit(successupdateprofile());
    }).catchError((error) {
      emit(errorupdateprofile());

      print(error.toString());
    });
  }

  void sentpost(
      {String link_profile_image,
      String username,
      String date,
      String text_post,
      int likes = 0,
      int comments = 0,
      Map text_comment
      //File post_image,
      //  String link_post_image
      }) {
    emit(withingpostsent());

    FirebaseFirestore.instance.collection("posts").add({
      "profile_image": link_profile_image,
      "date": date,
      "text_post": text_post,
      "user_name": username,
      "likes": likes,
      "comments": comments,
      "text_comment": text_comment

      //"post_image": link_post_image,
    }).then((value) {
      print("success post sent");

      emit(successpostsent());
    }).catchError((error) {
      print(error.toString());

      emit(errorpostsent());
    });
  }

  void uploadpostimage() async {
    print("start upload post image...");
    emit(withingpostimagesent());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(post_image.path).pathSegments.last} ")
        .putFile(post_image)
        .then((value) {
      print("success upload cover image...");

      value.ref.getDownloadURL().then((value) async {
        const_post_image_link = await value.toString();
        print(value.toString());
        print("get post image link success");

        emit(successpostimagesent());
      }).catchError((error) {
        print(error.toString());

        emit(errorpostimagesent());
      });
    }).catchError((error) {
      print(error.toString());

      emit(errorpostimagesent());
    });
  }

  List mygetposts = [];
  List post_id = [];

  Stream getpost() {
    mygetposts = [];

    print("Start get posts");
    emit(withingpostget());
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) async {
        mygetposts.add(element.data());
        post_id.add(element.id);

        print(mygetposts.toString());
      });
      print(mygetposts.length);

      print("get posts succefull");

      emit(successpostget());
    }).catchError((error) {
      print(error.toString());
      emit(errorpostget());
    });
  }

  String count_like;

  void setlike(String postid, String id) {
    emit(withinglike());

    FirebaseFirestore.instance
        .collection("posts")
        .doc(postid)
        .collection("likes")
        .doc(id)
        .set({"like": true}).then((value) {
      print("liked");
      emit(successlike());
    }).catchError((error) {
      print(error.toString());

      emit(errorlike());
    }).then((value) {
      FirebaseFirestore.instance
          .collection("posts")
          .doc(postid)
          .collection("likes")
          .get()
          .then((value) {
        count_like = value.size.toString();
        print(value.size.toString());
      }).catchError((error) {
        print(error.toString());
      });
    }).catchError((error) {});
  }

  // void removelike(String postid) {
  //   emit(withingromvelike());
  //   FirebaseFirestore.instance
  //       .collection("posts")
  //       .doc(postid)
  //       .get()
  //       .then((value) async {
  //     count_like = await value.data()["likes"];
  //     if (count_like == 0)
  //       return;
  //     else {
  //       FirebaseFirestore.instance
  //           .collection("posts")
  //           .doc(postid)
  //           .update({"likes": count_like - 1}).then((value) {
  //         print(count_like.toString());
  //         print("remove like succefull");
  //         emit(successromvelike());
  //       }).catchError((error) {
  //         print(error.toString());
  //
  //         emit(errorromvelike());
  //       });
  //     }
  //   }).then((value) {});
  // }

  List list_conversation = [];

  String image_conv;
  String uid_conv;

  String name_conv;

  String date_conv;

  String last_mass_conv;

  void get_user_conversation(// {String user_uid,
      // String image,
      // String name,
      // String date,
      // String last_message}

      ) {
    emit(withinggetuserconv());
    list_conversation = [];
    FirebaseFirestore.instance.collection("conversation").get().then((value) {
      value.docs.forEach((element) {
        list_conversation.add(element.data());
        print(list_conversation.toString());
        emit(successgetuserconv());
      });

      // image_conv=value.data()["image"]  ;
      // uid_conv=value.data()["uid"]  ;
      // name_conv =value.data()["name"]  ;
      // date_conv = value.data()["date"] ;
      // last_mass_conv = value.data()["last_message"] ;
    }).catchError((error) {
      print(error.toString());
      emit(errorgetuserconv());
    });
  }

  void sent_message(
      { String revised_uid, String text, String date}) {
    emit(withingmessagesent());
    FirebaseFirestore.instance
        .collection("users")
        .doc(const_uid)
        .collection("chats")
        .doc(revised_uid)
        .collection("all message")
        .add({
      "text": text,
      "date": date,
      "my_id": const_uid,
      "recived": revised_uid
    }).then((value) {
      print("message sent successs");
      emit(successmessagesent());
    }).catchError((error) {
    }).catchError((error) {
      print(error.toString());
      emit(errormessagesent());
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(revised_uid)
        .collection("chats")
        .doc(const_uid)
        .collection("all message")
        .add({
      "text": text,
      "date": date,
      "my_id": const_uid,
      "recived": revised_uid
    }).then((value) {
      print("message sent successs");
      emit(successmessagesent());
    }).catchError((error) {
      print(error.toString());
      emit(errormessagesent());
    });





  }

  List message = [];

  Stream get_message({List recivedid , int index }) {
    emit(withinggetmessage());
    FirebaseFirestore.instance
        .collection("users")
        .doc(const_uid)
        .collection("chats")
        .doc(recivedid[index]["uid"])
        .collection("all message")
        .orderBy("date", descending: true)
        .snapshots()
        .listen((event) {
      print("staerted");
      message = [];

      event.docs.forEach((element) {
        message.add(element.data());
      });
    });
  }

  List allusers;

  void get_allusers() {
    allusers = [];
    emit(withinggetgetallusers());
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        if (element.id != const_uid) allusers.add(element.data());
      });
      print(allusers.toString());
      emit(successgetallusers());
    }).catchError((error) {
      print(error.toString());
      emit(errorgetuserconv());
    });
  }
}
