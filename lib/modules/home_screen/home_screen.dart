// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maf_carrefour/constants/components.dart';
import 'package:maf_carrefour/cubit/cubit.dart';
import 'package:maf_carrefour/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> convItems = [
      convenienceBuilder(
          text1: "Save Big",
          text2: "Buy Bulk",
          color: const Color.fromARGB(255, 254, 0, 0),
          icon: Icons.add_box),
      convenienceBuilder(
          text1: "Quick",
          text2: "Buy Again",
          color: const Color.fromARGB(255, 228, 135, 14),
          icon: Icons.add_box),
      convenienceBuilder(
          text1: "Discover",
          text2: "Our Leaflet",
          color: const Color.fromARGB(255, 221, 35, 38),
          icon: Icons.add_box),
      convenienceBuilder(
          text1: "Quick",
          text2: "Buy Again",
          color: const Color.fromARGB(255, 19, 93, 168),
          icon: Icons.add_box),
    ];
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) 
      {
        var cubit = AppCubit.get(context);
        return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromARGB(255, 142, 20, 59)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              "MyCLUB",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                            Spacer(),
                            Text("Earn More Everyday",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: const [
                            Text(
                              "POINTS",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            Spacer(),
                            Text("228.39", style: TextStyle(color: Colors.white))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: const [
                            Text(
                              "EGP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            Spacer(),
                            Text("22.83", style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CarouselSlider.builder(
                  itemCount: 3,
                  itemBuilder: (context, index, realIndex) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Image(
                              image: AssetImage(
                                'assets/images/digital-art.jpg',
                              ),
                            )),
                      ),
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    height: 200,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  )),
              const Text(
                "For Your Convenience",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => convItems[index],
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 5),
                    itemCount: convItems.length),
              ),
              const SizedBox(height: 10),
              const Text("Top Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                childAspectRatio: 0.8,
                mainAxisSpacing: 20,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children: [
                  categoryBuilder(text: 'Best Price'),
                  categoryBuilder(text: 'Fruits & Begetables'),
                  categoryBuilder(text: 'Dairy Products'),
                  categoryBuilder(text: 'Meat & Poultry'),
                  categoryBuilder(text: 'Grocery'),
                  categoryBuilder(text: 'Beverages'),
                  categoryBuilder(text: 'Cooking Ingredients'),
                  categoryBuilder(text: 'TVs & Appliances'),
                  categoryBuilder(text: 'Laundry & Detergents'),
                  categoryBuilder(text: 'Personal Care'),
                  categoryBuilder(text: 'Cleaning Essentials'),
                  categoryBuilder(text: 'Baby Care'),
                ],
              ),
              const SizedBox(height: 15),
              const Text("Items",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10),
              Container(
                height:300,
                child: ListView.separated(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => productItemListBuilder(cubit.products[index],context),
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemCount: cubit.products.length,
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          ),
        ),
      );}
    );
  }

  Widget categoryBuilder({required String text}) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 30,
          child: Image(
            image: AssetImage('assets/images/digital-art.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 5),
        Text(text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
      ],
    ));
  }

  Widget convenienceBuilder({
    required String text1,
    required String text2,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 130,
      height: 120,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  text1,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Spacer(),
                Icon(
                  icon,
                  color: Colors.white,
                )
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              text2,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
