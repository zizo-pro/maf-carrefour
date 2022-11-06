import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/cubit/cubit.dart';
import 'package:maf_carrefour/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      "Fresh Food",
      "Fruits,\nVegetables Herbs",
      "Food Cupboard",
      "Beverages",
      "Baby Products",
      "Frozen Food",
      "Organic Food",
      "Bakery & Pastry",
      "Pet Supplies",
      "Electronics & Appliances",
      "SmartPhones, Tablets & Wearables",
      "Health & beauty",
    ];
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(children: [
              Row(children: [
                Container(
                  width: 140,
                  child: Column(children: [
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return categoriesItems(
                              text: items[index],
                              index: index,
                              context: context);
                        },
                        separatorBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child:
                                  Container(height: 1, color: Colors.grey[300]),
                            ),
                        itemCount: items.length),
                  ]),
                ),
                Container(
                    width: 200,
                    child: Column(
                      children: const [Text('zoz')],
                    ))
              ])
            ]),
          );
        });
  }

  Widget categoriesItems(
      {required String text, required int index, required context}) {
    Color colr = MyColors.containerCategoriesBackGroundColor;
    return InkWell(
      onTap: () {
        colr = Colors.green;
        AppCubit.get(context).changeListCat(inte: index);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        // decoration: BoxDecoration(),
        color: colr,
        width: 140,
        child: Text(
          text,
          textAlign: TextAlign.start,
          maxLines: 3,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
