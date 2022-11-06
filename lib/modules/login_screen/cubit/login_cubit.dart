import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_states.dart';

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
}
