import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/components.dart';
import 'package:maf_carrefour/cubit/cubit.dart';
import 'package:maf_carrefour/cubit/states.dart';
import 'package:maf_carrefour/models/products_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Map<String,dynamic>> cartItems = [];
          var cubit = AppCubit.get(context);
          cubit.cart.forEach((element) {
            cubit.products.forEach((elem) {
              if (element["productItemId"] == elem.serial) {
                cartItems.add({"model":elem,"count":element["count"]});
              }
            });
          });
          return ConditionalBuilder(
            condition: cubit.cart.isNotEmpty,
            fallback: (context) {
              return Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 90,
                      backgroundColor: Color.fromARGB(20, 0, 151, 136),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color.fromARGB(40, 0, 151, 136),
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromARGB(255, 0, 151, 136),
                            child: Icon(Icons.shopping_cart_outlined,
                                color: Colors.white, size: 28)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your cart is empty!",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 0, 151, 136),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Start adding your favourite items to the cart now",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              );
            },
            builder: (context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => itemCartBuilder(cartItems[index],context),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: cartItems.length)
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
