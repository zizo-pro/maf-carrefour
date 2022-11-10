// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/constants/components.dart';
import 'package:maf_carrefour/layout/home_layout.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_cubit.dart';
import 'package:intl/intl.dart';

class CompleteSignUp extends StatelessWidget {
  CompleteSignUp({super.key, required this.user});
  UserCredential user;
  var phoneNumberController = TextEditingController();
  var dateOfBirthController = TextEditingController();
  var nationalityController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Complete your profile",
                style: TextStyle(
                    fontSize: 22,
                    color: MyColors.facbookColor,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Radio<int>(
                            value: 0,
                            groupValue: cubit.groupValue,
                            onChanged: (int? value) {
                              cubit.justEmit(value as int);
                            }),
                        const Text("Mr.")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio<int>(
                            value: 1,
                            groupValue: cubit.groupValue,
                            onChanged: (int? value) {
                              cubit.justEmit(value as int);
                            }),
                        const Text("Mrs.")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio<int>(
                            value: 2,
                            groupValue: cubit.groupValue,
                            onChanged: (int? value) {
                              cubit.justEmit(value as int);
                            }),
                        const Text("Mrs.")
                      ],
                    ),
                  ),
                ],
              ),
              defaultTextFormField(
                  type: TextInputType.phone,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a mobile number";
                    } else {
                      return null;
                    }
                  },
                  hintText: "Mobile Number",
                  controller: phoneNumberController),
              const SizedBox(
                height: 15,
              ),
              defaultTextFormField(
                  type: TextInputType.datetime,
                  suffixIcon: Icons.keyboard_arrow_down,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.parse('1920-01-01'),
                      initialDate: DateTime.now(),
                      lastDate: DateTime.now(),
                    ).then((value) => dateOfBirthController.text =
                        DateFormat.yMMMd().format(value!));
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your birth date";
                    } else {
                      return null;
                    }
                  },
                  hintText: "Date of birth",
                  controller: dateOfBirthController),
              const SizedBox(
                height: 15,
              ),
              defaultTextFormField(
                  type: TextInputType.text,
                  suffixIcon: Icons.keyboard_arrow_down,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please select your nationality";
                    } else {
                      return null;
                    }
                  },
                  hintText: "Nationality",
                  controller: nationalityController),
              const SizedBox(
                height: 25,
              ),
              defaultbutton(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      cubit.userCreate(
                          email: "${user.user!.email}",
                          firstName: "${user.user!.displayName}",
                          lastName: "",
                          phone: phoneNumberController.text,
                          dateOfBirth: dateOfBirthController.text,
                          nationality: nationalityController.text,
                          uId: user.user!.uid);
                      navigateAndFinish(context,const HomeLayout());
                    }
                  },
                  text: "CONTINUE")
            ],
          ),
        ),
      ),
    );
  }
}
