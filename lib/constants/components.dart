// ignore_for_file: constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/cubit/cubit.dart';
import 'package:maf_carrefour/models/products_model.dart';
import 'package:maf_carrefour/modules/login_screen/cubit/login_cubit.dart';

Widget defaultbutton(
        {double width = double.infinity,
        Color background = Colors.blue,
        required VoidCallback function,
        required String text,
        double? fontsiz = 12,
        BoxDecoration decoration = const BoxDecoration()}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
          color: background,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: MaterialButton(
        padding: const EdgeInsets.all(4),
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontsiz,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  required String? Function(String?)? validate,
  Function(String?)? onChange,
  required String hintText,
  required TextEditingController controller,
  Function()? onTap,
  required TextInputType type,
  IconData? suffixIcon,
}) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    validator: validate,
    onChanged: onChange,
    onTap: onTap,
    decoration: InputDecoration(
        suffixIcon: Icon(suffixIcon, size: 24, color: Colors.black),
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hintText,
        hintStyle: const TextStyle(
          color: MyColors.weirdBlueColor,
        ),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.weirdBlueColor, width: 1))),
  );
}

Widget passwordFormField({
  required TextEditingController controller,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  IconData suffix = Icons.visibility,
  VoidCallback? suffixPressed,
  bool isClickable = true,
  required color,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black),
        hintText: label,
        filled: true,
        fillColor: Colors.grey[100],
        hintStyle: TextStyle(
          color: color,
        ),
        suffix: InkWell(
          onTap: suffixPressed,
          child: Icon(suffix),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 1)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 1)),
      ),
    );

Widget passwordTextFormField(
    {required String? Function(String?)? validate,
    Function(String?)? onChange,
    required String hintText,
    required TextEditingController controller,
    Function()? onTap,
    Function()? onSuffixTap,
    bool isPassword = false,
    required BuildContext context,
    Color color = MyColors.weirdBlueColor}) {
  return TextFormField(
    keyboardType: TextInputType.visiblePassword,
    controller: controller,
    validator: validate,
    onChanged: onChange,
    onTap: onTap,
    obscureText: isPassword,
    decoration: InputDecoration(
        suffix: InkWell(
            onTap: () {
              LoginCubit.get(context).changePassowordVisibility();
            },
            child: const Icon(
              Icons.remove_red_eye_outlined,
              size: 24,
              color: Colors.black,
            )),
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hintText,
        hintStyle: TextStyle(
          color: color,
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 1))),
  );
}

void navigateTo(context, dynamic screen) =>
    Navigator.push(context, MaterialPageRoute(builder: ((context) => screen)));

void navigateAndFinish(context, dynamic screen) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: ((context) => screen)), (route) {
      return false;
    });

void showToast({required String msg, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget moreScreenItem(
        {required String label, required IconData icon, Function()? ontap}) =>
    InkWell(
      onTap: ontap,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Icon(icon, size: 25),
              const SizedBox(width: 10),
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18))
            ]),
          )),
    );

Widget productItemListBuilder(ProductModel model, BuildContext context) {
  double discount = double.parse("${model.discount}");
  double price = double.parse(
    "${model.price}",
  );
  Color priceColor;
  if (discount == 0.0) {
    priceColor = Colors.black;
  } else {
    priceColor = Colors.redAccent;
    price = price - (price * (discount / 100));
  }
  return Container(
    height: 300,
    width: 150,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300] as Color),
        borderRadius: BorderRadius.circular(4)),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image(image: NetworkImage(model.image as String)),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: 125,
          child: Text(
            "${model.name}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text("EGP ${price.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: priceColor)),
            Text("/Piece",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(4)),
              child: InkWell(
                  onTap: () {
                    AppCubit.get(context).addToCart(model: model);
                  },
                  child: const Icon(Icons.add, color: Colors.white))),
        )
      ]),
    ),
  );
}

Widget itemCartBuilder(Map<String, dynamic> map, context) {
  ProductModel model = map['model'];
  double discount = double.parse("${model.discount}");
  double price = double.parse(
    "${model.price}",
  );
  Color priceColor;
  if (discount == 0.0) {
    priceColor = Colors.black;
  } else {
    priceColor = Colors.redAccent;
    price = price - (price * (discount / 100));
  }
  return Dismissible(
    onDismissed: (details) {
      AppCubit.get(context).removeFromCart(model.serial);
    },
    key: Key(model.serial.toString()),
    child: Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300] as Color, width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.grey[300] as Color, width: 1)),
              child: Container(
                height: 75,
                width: 75,
                // padding: const EdgeInsets.all(2.0),
                child: Image.network(
                  "${model.image}",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 120,
                    child: Text(
                      "${model.name}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                const Spacer(),
                Text(price.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: priceColor)),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 249, 195, 195),
                          borderRadius: BorderRadius.circular(4)),
                      child: InkWell(
                          onTap: () {
                            AppCubit.get(context).removeFromCart(model.serial);
                          },
                          child: const Icon(
                            Icons.delete_outline,
                            color: Color.fromARGB(255, 213, 38, 38),
                          ))),
                  const SizedBox(width: 15),
                  Text("${map['count']}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 15),
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 213, 38, 38),
                          borderRadius: BorderRadius.circular(4)),
                      child: InkWell(
                          onTap: () {
                            AppCubit.get(context).addToCart(model: model);
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ))),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
