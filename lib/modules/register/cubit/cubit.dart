import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/login_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitial());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  late SocialLoginModel loginModel;
  bool isPasswordShow = true;
  IconData suffix = Icons.visibility_outlined;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        uId: value.user!.uid,
        phone: phone,
        email:email,
        name: name,
      );
    })
        .catchError((error) {
      emit(SocialRegisterError(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId
  }) {
    UserModel model = UserModel(
      cover: 'https://img.freepik.com/free-photo/carefree-pleased-teenage-girl-has-fun-dances-joyfully-with-raised-arms-being-entertained-amused-wears-summer-clothes_273609-30519.jpg?w=740&t=st=1675426536~exp=1675427136~hmac=d09897d79220d039ae89313e1a2e3d8eadc3976746a8451f68c8bbeda78fc7a8',
      image: 'https://img.freepik.com/free-photo/carefree-pleased-teenage-girl-has-fun-dances-joyfully-with-raised-arms-being-entertained-amused-wears-summer-clothes_273609-30519.jpg?w=740&t=st=1675426536~exp=1675427136~hmac=d09897d79220d039ae89313e1a2e3d8eadc3976746a8451f68c8bbeda78fc7a8',
      bio: 'Write your bio',
      isEmailVerfied: false,
      uId: uId,
      phone: phone,
      name: name,
      email: email,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .set(model.toMap()).then((value) {
      emit(SocialCreateSucess());
    }).catchError((error) {
      emit(SocialCreateError(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibility());
  }
}
