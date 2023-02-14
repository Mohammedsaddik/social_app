import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/login_model.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/network/end_point/end_point.dart';
import 'package:social_app/network/remote/dio_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitial());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  late SocialLoginModel loginModel;
  bool isPasswordShow = true;
  IconData suffix = Icons.visibility_outlined;
  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(SocialLoginLoading());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSucess(value.user!.uid));
    }).catchError((error)
    {
      emit(SocialLoginError(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginChangePasswordVisibility());
  }
}
