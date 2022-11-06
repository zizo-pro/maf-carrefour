// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/constants/components.dart';
import 'package:maf_carrefour/models/user_model.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_states.dart';
import 'package:maf_carrefour/shared/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isEmailValid = false;
  Color button = MyColors.weirdBlueColor.withOpacity(0.4);
  void checkEmail(bool convert) {
    isEmailValid = convert;
    if (convert == true) {
      button = MyColors.weirdBlueColor;
    } else {
      button = MyColors.weirdBlueColor.withOpacity(0.4);
    }
    emit(LoginIsEmailValidState());
  }

  List<String> title = ["Mr", "Mrs", "Miss/Ms"];
  int groupValue = 0;
  void justEmit(int groupval) {
    groupValue = groupval;
    print(title[groupval]);
    emit(LoginIsEmailValidState());
  }

  bool isPass = true;

  void changePassowordVisibility() {
    isPass = !isPass;

    emit(LoginChangPassVisibilityState());
  }

  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String dateOfBirth,
    required String nationality,
  }) {
    emit(LoginSocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
          dateOfBirth: dateOfBirth,
          email: email,
          firstName: firstName,
          lastName: lastName,
          nationality: nationality,
          phone: phone,
          uId: value.user!.uid);
      CacheHelper.saveData(key:'uId',value:value.user!.uid);
      emit(LoginSocialRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginSocialRegisterErrorState());
    });
  }

  void userCreate(
      {required String email,
      required String firstName,
      required String lastName,
      required String phone,
      required String dateOfBirth,
      required String nationality,
      required String uId}) {
    emit(LoginSocialCreateUserLoadingState());
    UserModel model = UserModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      dateOfBirth: dateOfBirth,
      nationality: nationality,
      phone: phone,
      uId: uId,
      title: title[groupValue],
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(LoginSocialCreateUserSuccessState());
    }).catchError((error) {
      emit(LoginSocialCreateUserErrorState());
      print(error.toString());
    });
  }

  void loginTest(){
  }
}
