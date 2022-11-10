// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/constants/components.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_cubit.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_states.dart';

class PasswordLoginScreen extends StatelessWidget {
  PasswordLoginScreen({super.key, required this.userEmail});
  var passwordController = TextEditingController();
  String userEmail;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text("password",
                      style: TextStyle(
                          color: MyColors.passwordColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  const SizedBox(height: 40),
                  passwordFormField(
                    isPassword: cubit.isPass,
                    suffixPressed: () {
                      cubit.changePassowordVisibility();
                    },
                    validate: (value) {
                      if (cubit.usersemail.contains(value)) {
                        return null;
                      } else {
                        return 'Please register first';
                      }
                    },
                    onChange: (value) {
                      
                    },
                    label: "Password",
                    color: MyColors.passwordColor,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 25),
                  defaultbutton(
                      function: () {
                        cubit.userLogin(
                            email: userEmail,
                            password: passwordController.text);
                      },
                      text: "Login",
                      background: MyColors.passwordColor),
                ],
              ),
            ));
      },
    );
  }
}
