import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/cubit/states.dart';
import 'package:maf_carrefour/modules/cart_screen/cart_screen.dart';
import 'package:maf_carrefour/modules/categories_screen/categories_screen.dart';
import 'package:maf_carrefour/modules/deals_screen.dart/deals_screen.dart';
import 'package:maf_carrefour/modules/home_screen/home_screen.dart';
import 'package:maf_carrefour/modules/more_screen/more_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    HomeScreen(),
    CategoriesScreen(),
    DealsScreen(),
    CartScreen(),
    MoreScreen()
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  int listCategory = 0;
  void changeListCat({required int inte}) {
    listCategory = inte;

    emit(AppChangeListCategoryState());
  }
}
