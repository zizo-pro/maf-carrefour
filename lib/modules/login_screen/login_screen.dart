// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/constants/components.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_cubit.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_states.dart';
import 'package:maf_carrefour/modules/register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var kay = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var emailController = TextEditingController();
          var cubit = LoginCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Form(
                key: kay,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Login to Your Account",
                          style: TextStyle(
                              color: MyColors.weirdBlueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      defaultTextFormField(
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            cubit.checkEmail(true);
                            return "empt";
                          } else {
                            cubit.checkEmail(false);
                            return 'field';
                          }
                        },
                        onChange: (value) {
                          if (value!.contains("@")) {
                            cubit.checkEmail(true);
                          } else {
                            cubit.checkEmail(false);
                          }
                        },
                        hintText: "Email Address",
                        controller: emailController,
                      ),
                      const SizedBox(height: 25),
                      defaultbutton(
                          function: () {
                            if (cubit.isEmailValid) {
                            } else {
                              showToast(
                                  msg: "Please Check your Email Format",
                                  state: ToastStates.ERROR);
                            }
                          },
                          text: "Continue",
                          background: cubit.button),
                      const SizedBox(height: 15),
                      const Text(
                        "OR",
                        style: TextStyle(
                            color: Color.fromARGB(255, 116, 116, 116)),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: const BoxDecoration(
                            color: MyColors.facbookColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.facbookColor),
                          onPressed: () {},
                          label: const Text(
                            "Continue with Facebook",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          icon: const Icon(Icons.facebook),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, elevation: 10),
                          onPressed: () {},
                          label: const Text(
                            "Continue with Google",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          icon: const Icon(
                            Icons.facebook,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont have an account?'),
                          const SizedBox(width: 2),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: const Text('Register',
                                  style:
                                      TextStyle(color: MyColors.facbookColor))),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
