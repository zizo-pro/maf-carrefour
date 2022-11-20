import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/constants/constans.dart';
import 'package:maf_carrefour/cubit/states.dart';
import 'package:maf_carrefour/models/products_model.dart';
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

  void addproduct() {
    ProductModel model = ProductModel(
      image: '',
      name: 'SanDisk 32 GB Ultra Fit USB 3.1 Flash Drive',
      price: "139.00",
      serial: "554432521",
      stock: '100',
      discount: '0',
    );
    FirebaseFirestore.instance
        .collection('products')
        .doc("554432521")
        .set(model.toMap())
        .then((value) => null)
        .catchError((error) {
      print(error);
    });
  }

  List<ProductModel> products = [];
  void getProducts() {
    emit(AppGetProductsLoadingState());
    FirebaseFirestore.instance.collection('products').get().then((value) {
      value.docs.forEach((element) {
        products.add(ProductModel.fromJson(element.data()));
      });
      emit(AppGetProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetProductsErrorState());
    });
  }

  List<dynamic> cart = [];
  void getCart() {
    cart = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        cart.add(element.data());
      });
      emit(AppAddToCartState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  void addToCart({required ProductModel model, int count = 1}) {
    cart.forEach((element) {
      if (element["productItemId"] == model.serial) {
        count = element['count'] + 1;
      }
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection("cart")
        .doc(model.serial)
        .set({"productItemId": model.serial, "count": count}).then((value) {
      getCart();
    });
  }

  void removeFromCart(id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .doc(id)
        .delete()
        .then((value) {
      getCart();
    });
  }
}
