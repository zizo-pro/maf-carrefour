import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/cubit/cubit.dart';
import 'package:maf_carrefour/cubit/states.dart';
import 'package:maf_carrefour/modules/home_screen/home_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
      return ConditionalBuilder(
        condition:  cubit.products.isNotEmpty ,
        fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        builder: (BuildContext context) =>
        Scaffold(
          backgroundColor: Color.fromARGB(255, 250, 250, 250),
            appBar: AppBar(backgroundColor: MyColors.appBarColor,),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (value) => cubit.changeBottomNav(value),
              items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label: "Categories"),
              BottomNavigationBarItem(icon: Icon(Icons.label_important_outline),label: "Deals"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded),label: "More"),
            ],
            unselectedItemColor: MyColors.bottomNavUnselected,
            selectedItemColor: MyColors.bottomNavSelected,
            ),
            ),
      );}
    );
  }
}
