import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/constants/components.dart';
import 'package:maf_carrefour/layout/home_layout.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_cubit.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_states.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var phoneNumberController = TextEditingController();
    var emailAddressController = TextEditingController();
    var passwordController = TextEditingController();
    var dateOfBirthController = TextEditingController();
    var nationalityController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Create new Account",
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
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your first name";
                              } else {
                                return null;
                              }
                            },
                            hintText: "First Name",
                            controller: firstNameController),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your last name";
                              } else {
                                return null;
                              }
                            },
                            hintText: "Last Name",
                            controller: lastNameController),
                        const SizedBox(
                          height: 15,
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
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (cubit.usersemail.contains(value)) {
                                return "Email is already used";
                              }
                              if (value!.contains("@")) {
                                return null;
                              } else {
                                return "Invalid Email Address";
                              }
                            },
                            hintText: "Email Address",
                            controller: emailAddressController),
                        const SizedBox(
                          height: 15,
                        ),
                        passwordFormField(
                            suffixPressed: () {
                              cubit.changePassowordVisibility();
                            },
                            isPassword: cubit.isPass,
                            validate: (value) {
                              if (value!.length < 8) {
                                return "Password is too Short";
                              }
                              return null;
                            },
                            label: "Password",
                            controller: passwordController,
                            color: MyColors.weirdBlueColor),
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
                                cubit.userRegister(
                                    email: emailAddressController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    phone: phoneNumberController.text,
                                    password: passwordController.text,
                                    dateOfBirth: dateOfBirthController.text,
                                    nationality: nationalityController.text);
                                navigateAndFinish(context, const HomeLayout());
                              }
                            },
                            text: "REGISTER",
                            fontsiz: 16),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "By proceeding you accept the terms & conditions",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
