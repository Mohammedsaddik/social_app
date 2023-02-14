// ignore_for_file: sort_child_properties_last, constant_identifier_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/style/colors.dart';
import 'package:social_app/style/icon_broken.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

class CostumTextFormFeild extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final dynamic onSubmit;
  final dynamic onChange;
  final dynamic onTap;
  final dynamic validate;
  final dynamic prefix;
  final dynamic suffix;
  final dynamic suffixPressed;
  final bool isPassword;

  CostumTextFormFeild({
    required this.label,
    required this.controller,
    required this.type,
    required this.prefix,
    this.onSubmit,
    this.onChange,
    required this.validate,
    this.onTap,
    this.suffixPressed,
    this.suffix,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        suffixIcon: Icon(suffix),
        prefixIcon: GestureDetector(
          onTap: suffixPressed,
          child: Icon(
            prefix,
          ),
        ),
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class Defaultbotton extends StatelessWidget {
  Defaultbotton(
      {this.background = Colors.blue,
      this.width = double.infinity,
      required this.text,
      this.radius = 5.0,
      required this.function});

  final double width;
  final Color background;
  final String text;
  final double radius;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            // ignore: non_constant_identifier_names
            color: Colors.white,
          ),
        ),
        onPressed: function,
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
  }
}

Widget defaultTextButtom({
  required Function function,
  required String text,
}) =>
    TextButton(child: Text(text.toUpperCase()), onPressed: function(),);

void showToast({
  required String message,
  required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR, WARRING }

Color chooseToastColor(ToastState state) {
  Color color;

  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARRING:
      color = Colors.blue;
      break;
  }
  return color;
}
