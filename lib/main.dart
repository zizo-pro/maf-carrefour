// ignore_for_file: deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/constans.dart';
import 'package:maf_carrefour/cubit/cubit.dart';
import 'package:maf_carrefour/cubit/states.dart';
import 'package:maf_carrefour/firebase_options.dart';
import 'package:maf_carrefour/layout/home_layout.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_cubit.dart';
import 'package:maf_carrefour/modules/login_screen/login_screen.dart';
import 'package:maf_carrefour/shared/bloc_observer.dart';
import 'package:maf_carrefour/shared/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  Widget widget;

  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  if (uId != null) {
    widget = const HomeLayout();
  } else {
    widget = LoginScreen();
  }

  BlocOverrides.runZoned(() {
    runApp(MyApp(
      startWidget: widget,
    ));
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({
    Key? key,
    this.startWidget,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..getProducts()..getCart(),
        ),
        BlocProvider(
          create: (context) => LoginCubit()..getAllUsers(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              home: startWidget,
            );
          }),
    );
  }
}
