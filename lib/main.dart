// ignore_for_file: deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/cubit/cubit.dart';
import 'package:maf_carrefour/cubit/states.dart';
import 'package:maf_carrefour/firebase_options.dart';
import 'package:maf_carrefour/layout/home_layout.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_cubit.dart';
import 'package:maf_carrefour/modules/login_screen/login_screen.dart';
import 'package:maf_carrefour/shared/bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) {

  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: MyBlocObserver());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              home: LoginScreen(),
            );
          }),
    );
  }
}
