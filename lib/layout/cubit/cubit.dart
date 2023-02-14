// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/models/meessage_model.dart';
import 'package:social_app/models/new_post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/shared/constant/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Settings',
  ];

  void changeBottum(int index) {
    if (index == 1) getUsers();
    if (index == 2)
      emit(SocialNewPosttate());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  UserModel? model;

  void getUserData() {
    emit(SocialGetUserLoadindState());
    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

// change profile photos
  final ImagePicker _picker = ImagePicker();
  File? profileimage;

  Future<void> getProfilePic() async {
    emit(SocialProfileImagePickedLoadingState());
    final pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      profileimage = File(pickedimage.path);
      print(pickedimage.path);
      emit(SocialProfileImagePickedSucessState());
    } else {
      print('No Image Selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  // change cover photos
  File? coverimage;

  Future<void> getCoverPic() async {
    emit(SocialCoverImagePickedLoadingState());
    final pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      coverimage = File(pickedimage.path);
      emit(SocialCoverImagePickedSucessState());
    } else {
      print('No Image Selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSucessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(coverimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSucessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(UpdateUserDataLoadingState());
    UserModel usermodel = UserModel(
      name: name,
      email: model!.email,
      phone: phone,
      uId: model!.uId,
      bio: bio,
      cover: cover ?? model!.cover,
      image: image ?? model!.image,
      isEmailVerfied: false,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.uId)
        .update(usermodel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

////////////////////////////// set post////////////////////////////////////////

  File? postimage;

  Future<void> getPostImage() async {
    emit(SocialPostImagePickedLoadingState());
    final pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      postimage = File(pickedimage.path);
      emit(SocialPostImagePickedSucessState());
    } else {
      print('No Image Selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postimage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postimage!.path).pathSegments.last}')
        .putFile(postimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostSucessState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSucessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

//////////////////////////////get post//////////////////////////////////////////
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          comments.add(value.docs.length);
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostSucessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

//////////////////////////////like post/////////////////////////////////////////

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSucessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

//////////////////////////////comment post//////////////////////////////////////
  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialCommentPostSucessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

//////////////////////////////get all user//////////////////////////////////////

  List<UserModel> users = [];

  void getUsers() {
    users = [];
    if (users.length == 0)
      FirebaseFirestore.instance.collection('user').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUserSucessState());
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
  }

//////////////////////////////chats/////////////////////////////////////////////
//////////////////////////////send_message//////////////////////////////////////
  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      senderId: model!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSucessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSucessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

///////////////////////////////////get_message//////////////////////////////////
  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSucessState());
    });
  }
}
