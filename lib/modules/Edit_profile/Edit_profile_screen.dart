// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, avoid_web_libraries_in_flutter, must_be_immutable, unnecessary_null_comparison, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/shared/componnen/commponnents.dart';
import 'package:social_app/style/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phonrController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userModel = SocialCubit
        .get(context)
        .model;
    var profileImage = SocialCubit
        .get(context)
        .profileimage;
    var coverImage = SocialCubit
        .get(context)
        .coverimage;

    nameController.text = userModel!.name;
    bioController.text = userModel.bio;
    phonrController.text = userModel.phone;

    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit profile'),
            titleSpacing: 4.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phonrController.text,
                    bio: bioController.text,
                  );
                },
                child: Text('UPDATE'),
              ),
              SizedBox(width: 15.0),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  if (state is UpdateUserDataLoadingState)
                    SizedBox(height: 10.0),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(userModel!.cover)
                                        : FileImage(coverImage)
                                    as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverPic();
                                },
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                              Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage != null
                                    ? FileImage(profileImage)
                                    : NetworkImage(userModel.image)
                                as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfilePic();
                              },
                              icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit
                      .get(context)
                      .profileimage != null || SocialCubit
                      .get(context)
                      .coverimage != null)
                    Row(
                      children:
                      [
                        if(SocialCubit
                            .get(context)
                            .profileimage != null)
                          Expanded(
                            child: Column(
                              children:
                              [
                                Defaultbotton(
                                  text: 'upload profile',
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phonrController.text,
                                      bio:bioController.text,
                                    );
                                  },
                                ),
                                if (state is UpdateUserDataLoadingState)
                                  SizedBox(height: 5.0,),
                                if (state is UpdateUserDataLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(width: 2.0,),
                        if(SocialCubit
                            .get(context)
                            .coverimage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Defaultbotton(
                                  text: 'Upload cover',
                                  function: ()
                                  {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phonrController.text,
                                      bio:bioController.text,
                                    );
                                  },
                                ),
                                if (state is UpdateUserDataLoadingState)
                                  SizedBox(height: 5.0,),
                                if (state is UpdateUserDataLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if(SocialCubit
                      .get(context)
                      .profileimage != null || SocialCubit
                      .get(context)
                      .coverimage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  CostumTextFormFeild(
                    label: 'Name',
                    controller: nameController,
                    type: TextInputType.name,
                    prefix: IconBroken.User,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Sorry ! , name can't be empty, Enter your name ";
                      } else {}
                    },
                  ),
                  SizedBox(height: 10.0),
                  CostumTextFormFeild(
                    label: 'Bio',
                    controller: bioController,
                    type: TextInputType.text,
                    prefix: IconBroken.Info_Circle,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Sorry ! , bio can't be empty, Enter your bio ";
                      } else {}
                    },
                  ),
                  SizedBox(height: 10.0),
                  CostumTextFormFeild(
                    label: 'Phone',
                    controller: phonrController,
                    type: TextInputType.phone,
                    prefix: IconBroken.Call,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Sorry ! , Phone can't be empty, Enter your Phone ";
                      } else {}
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
