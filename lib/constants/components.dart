// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_cubit.dart';

Widget defaultbutton(
        {double width = double.infinity,
        Color background = Colors.blue,
        required VoidCallback function,
        required String text,
        double? fontsiz = 12,
        BoxDecoration decoration = const BoxDecoration()}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
          color: background,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: MaterialButton(
        padding: const EdgeInsets.all(4),
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontsiz,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  required String? Function(String?)? validate,
  Function(String?)? onChange,
  required String hintText,
  required TextEditingController controller,
  Function()? onTap,
  required TextInputType type,
  IconData? suffixIcon,
}) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    validator: validate,
    onChanged: onChange,
    onTap: onTap,
    decoration: InputDecoration(
        suffixIcon: Icon(suffixIcon, size: 24, color: Colors.black),
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hintText,
        hintStyle: const TextStyle(
          color: MyColors.weirdBlueColor,
        ),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.weirdBlueColor, width: 1))),
  );
}

Widget passwordFormField({
  required TextEditingController controller,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  IconData suffix = Icons.visibility,
  VoidCallback? suffixPressed,
  bool isClickable = true,
  required color,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black),
        hintText: label,
        filled: true,
        fillColor: Colors.grey[100],
        hintStyle: TextStyle(
          color: color,
        ),
        suffix: InkWell(
          onTap: suffixPressed,
          child: Icon(suffix),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 1)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 1)),
      ),
    );

Widget passwordTextFormField(
    {required String? Function(String?)? validate,
    Function(String?)? onChange,
    required String hintText,
    required TextEditingController controller,
    Function()? onTap,
    Function()? onSuffixTap,
    bool isPassword = false,
    required BuildContext context,
    Color color = MyColors.weirdBlueColor}) {
  return TextFormField(
    keyboardType: TextInputType.visiblePassword,
    controller: controller,
    validator: validate,
    onChanged: onChange,
    onTap: onTap,
    obscureText: isPassword,
    decoration: InputDecoration(
        suffix: InkWell(
            onTap: () {
              LoginCubit.get(context).changePassowordVisibility();
            },
            child: const Icon(
              Icons.remove_red_eye_outlined,
              size: 24,
              color: Colors.black,
            )),
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hintText,
        hintStyle: TextStyle(
          color: color,
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 1))),
  );
}

void navigateTo(context, dynamic screen) =>
    Navigator.push(context, MaterialPageRoute(builder: ((context) => screen)));

void navigateAndFinish(context, dynamic screen) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: ((context) => screen)), (route) {
      return false;
    });

void showToast({required String msg, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
