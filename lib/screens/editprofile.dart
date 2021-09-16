import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sochial_app/const/const_var.dart';
import 'package:sochial_app/const/methods.dart';
import 'package:sochial_app/cubit_home/home_cubit.dart';
import 'package:sochial_app/cubit_home/home_states.dart';
import 'package:sochial_app/cubit_login/login_cubit.dart';
import 'package:sochial_app/shared/shared_pre.dart';

class edit_profile extends StatefulWidget {
  @override
  _edit_profileState createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  TextEditingController controller_name = TextEditingController();

  TextEditingController controller_bio = TextEditingController();

  TextEditingController controller_email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => social_cubit()),
        BlocProvider(create: (context) => home_cubit()),
      ],
      child: BlocConsumer<home_cubit, home_states>(
        listener: (context, home_states) async {
          if (home_states is successupdateprofile) {
            const_username = CachHelper.getData(key: "name");

            const_bio = CachHelper.getData(key: "bio");
            print(const_username.toString());
          }


          if(home_states is successschangeprofileimmage ) {

            await home_cubit.get(context).updateprofiledata(
                bio_update: controller_bio.text,
                name_update: controller_name.text,
                image_cover_update:  const_link_image_cover,
                image_profile_update:
                const_link_image_profile);
            if(home_states is successsloadprofilecoverimmage ) {


              await home_cubit.get(context).updateprofiledata(
                  bio_update: controller_bio.text,
                  name_update: controller_name.text,
                  image_cover_update:  const_link_image_cover,
                  image_profile_update:
                  const_link_image_profile);

            }

          }

        },
        builder: (context, home_states) {
          controller_name.text = const_username;
          controller_bio.text = const_bio;
          controller_email.text = const_email;

          return Scaffold(
            appBar: backAppBar(
              title: "Edit profile",
              context: context,

            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(height: 5,) ,
                      if (home_states is withingupdateprofile)
                        LinearProgressIndicator(color: Colors.red, ),
                      Stack(
                        children: [
                          Container(
                              child: Stack(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image(
                                  image: home_cubit
                                              .get(context)
                                              .pofile_cover_image !=
                                          null
                                      ? FileImage(home_cubit
                                          .get(context)
                                          .pofile_cover_image)
                                      : const_link_image_cover == null
                                          ? AssetImage(
                                              "lib/my_images/blank-profile-picture-973460_640.png")
                                          : NetworkImage(
                                             const_link_image_cover),
                                  height: 190,
                                  width: MediaQuery.of(context).size.width ,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Center(
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 160,
                                      ),
                                      CircleAvatar(
                                        child: IconButton(
                                            onPressed: () {
                                              home_cubit
                                                  .get(context)
                                                  .getprofilecoverImage();
                                            },
                                            icon: Icon(
                                              Icons.add_a_photo_outlined,
                                              color: Colors.blue,
                                              size: 20,
                                            )),
                                        backgroundColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                          Column(
                            children: [
                              SizedBox(
                                height: 140,
                              ),
                              Container(
                                  child: Stack(
                                children: [
                                  Center(
                                    child: CircleAvatar(
                                      backgroundImage: home_cubit
                                                  .get(context)
                                                  .profile_image !=
                                              null
                                          ? FileImage(home_cubit
                                              .get(context)
                                              .profile_image)
                                          : const_link_image_profile == null
                                              ? AssetImage(
                                                  "lib/my_images/blank-profile-picture-973460_640.png")
                                              : NetworkImage(
                                                  const_link_image_profile),
                                      radius: 50,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 80,
                                        ),
                                        CircleAvatar(
                                          child: IconButton(
                                              onPressed: () {
                                                home_cubit
                                                    .get(context)
                                                    .getprofileImage();
                                              },
                                              icon: Icon(
                                                Icons.add_a_photo_outlined,
                                                color: Colors.blue,
                                                size: 20,
                                              )),
                                          backgroundColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: [
                              defaultTextField(
                                labeltext: "Name",
                                hinttext: "Enter your name",
                                valdiate: (val) {
                                  if (val == null) {
                                    return "Name must not be embty";
                                  }
                                },
                                ontap: () {},
                                prfixicon: Icons.person_sharp,
                                keypboardtybe: TextInputType.name,
                                texteditingcontroller: controller_name,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              defaultTextField(
                                  labeltext: "Bio",
                                  hinttext: "Enter your bio",
                                  ontap: () {},
                                  prfixicon: Icons.article,
                                  keypboardtybe: TextInputType.emailAddress,
                                  texteditingcontroller: controller_bio),
                              SizedBox(
                                height: 10,
                              ),
                              defaultTextField(
                                labeltext: "Email",
                                hinttext: "Enter your email",
                                valdiate: (val) {
                                  if (val == null) {
                                    return "Email must not be embty";
                                  }
                                },
                                ontap: () {},
                                prfixicon: Icons.alternate_email,
                                keypboardtybe:
                                    TextInputType.numberWithOptions(),
                                texteditingcontroller: controller_email,
                                isenableld: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                          clipBehavior: Clip.antiAlias,
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.blueGrey)),
                          onPressed: () async {
                            if (home_cubit.get(context).pofile_cover_image !=
                                    null ||
                                home_cubit.get(context).profile_image != null) {
                               home_cubit
                                  .get(context)
                                  .uploadprofileImage();

                               home_cubit
                                  .get(context)
                                  .uploadprofilecoverImage();


                               if(home_states is successschangeprofileimmage ) {

                                 await home_cubit.get(context).updateprofiledata(
                                     bio_update: controller_bio.text,
                                     name_update: controller_name.text,
                                     image_cover_update:  const_link_image_cover,
                                     image_profile_update:
                                     const_link_image_profile);
                                 if(home_states is successsloadprofilecoverimmage ) {


                                   await home_cubit.get(context).updateprofiledata(
                                       bio_update: controller_bio.text,
                                       name_update: controller_name.text,
                                       image_cover_update:  const_link_image_cover,
                                       image_profile_update:
                                       const_link_image_profile);

                                 }

                               }


                            } else {
                              await home_cubit.get(context).updateprofiledata(
                                  bio_update: controller_bio.text,
                                  name_update: controller_name.text,
                                  image_cover_update:  const_link_image_cover,
                                  image_profile_update:
                                      const_link_image_profile);
                            }
                          },
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.system_update_alt,
                                  color: Colors.lightBlue,
                                ),
                                Text(
                                  "Update",
                                  style: TextStyle(color: Colors.lightBlue),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
