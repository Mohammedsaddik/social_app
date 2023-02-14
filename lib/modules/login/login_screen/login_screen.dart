// ignore_for_file: prefer_const_constructors
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home-layout.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/register_screen/register_screen.dart';
import 'package:social_app/network/local_cash/cash_helper.dart';
import 'package:social_app/shared/componnen/commponnents.dart';
import 'package:social_app/style/colors.dart';

class SocialLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginError) {
            showToast(
              message: state.error,
              state: ToastState.ERROR,
            );
          }
          if (state is SocialLoginSucess) {
            CacheHelper.saveData
              (
              key: 'uId',
              value: state.uId,
            ).then((value)
            {
              navigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                            fontWeight: FontWeight.bold,
                            color: defaultColor,
                          ),
                        ),
                        Text(
                          'Login now to brows our hot offers',
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        CostumTextFormFeild(
                          label: 'Email adresse',
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          prefix: Icons.email_outlined,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Sorry ! , Email can't be empty, Enter your email ";
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        CostumTextFormFeild(
                          label: 'Password',
                          isPassword:
                          SocialLoginCubit
                              .get(context)
                              .isPasswordShow,
                          controller: passwordController,
                          type: TextInputType.phone,
                          prefix: Icons.lock_outline,
                          suffix: SocialLoginCubit
                              .get(context)
                              .suffix,
                          onTap: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                            ;
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Sorry ! , Password is too short ";
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoading,
                          builder: (context) =>
                              Defaultbotton(
                                radius: 5.0,
                                text: 'LOGIN',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                  ;
                                },
                              ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't an have account ?",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1,
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              child: Text(
                                "Register",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                  color: defaultColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
