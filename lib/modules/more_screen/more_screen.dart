import 'package:flutter/material.dart';
import 'package:maf_carrefour/constants/colors.dart';
import 'package:maf_carrefour/constants/components.dart';
import 'package:maf_carrefour/constants/constans.dart';
import 'package:maf_carrefour/cubit/cubit.dart';
import 'package:maf_carrefour/fill/filler.dart';
import 'package:maf_carrefour/shared/cache_helper.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(image: AssetImage("assets/images/digital-art.jpg")),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: MyColors.facbookColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text("scan&go",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Spacer(),
                        Icon(Icons.battery_0_bar, color: Colors.white)
                      ],
                    ),
                    const Text("The faster way to shop",
                        style: TextStyle(color: Colors.white, fontSize: 12))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            moreScreenItem(
                label: "Notifications Center",
                icon: Icons.notifications_none,
                ontap: (() {
                  AppCubit.get(context).addproduct();
                })),
            const SizedBox(height: 15),
            moreScreenItem(
                label: "Live Shopping",
                icon: Icons.videocam_outlined,
                ontap: () {
                  print(AppCubit.get(context).products[0]);
                }),
            const SizedBox(height: 15),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  moreScreenItem(label: "Profile", icon: Icons.person_outline),
                  wierdPadding(),
                  moreScreenItem(
                      label: "Addresses", icon: Icons.location_on_outlined),
                  wierdPadding(),
                  moreScreenItem(
                      label: "Orders", icon: Icons.check_box_outline_blank),
                  wierdPadding(),
                  moreScreenItem(
                      label: "Returns", icon: Icons.check_box_outline_blank),
                  wierdPadding(),
                  moreScreenItem(
                      label: "Buy Again", icon: Icons.refresh_outlined),
                  wierdPadding(),
                  moreScreenItem(
                      label: "Store Receipts",
                      icon: Icons.receipt_long_rounded),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  moreScreenItem(
                      label: "MyCLUB Card",
                      icon: Icons.card_membership_outlined),
                  wierdPadding(),
                  moreScreenItem(
                      label: "MyCLUB Offers",
                      icon: Icons.card_giftcard_outlined),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            moreScreenItem(label: "Saved Cards", icon: Icons.wallet_outlined),
            const SizedBox(
              height: 15,
            ),
            moreScreenItem(label: "Country", icon: Icons.ballot),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  moreScreenItem(
                      label: "Contact Us", icon: Icons.phone_android),
                  wierdPadding(),
                  moreScreenItem(label: "About Us", icon: Icons.info_outline),
                  wierdPadding(),
                  moreScreenItem(
                      label: "Terms & Conditions", icon: Icons.list_outlined),
                  wierdPadding(),
                  moreScreenItem(
                      label: "Privacy Policy", icon: Icons.lock_outline),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            moreScreenItem(
                label: "Logout",
                icon: Icons.exit_to_app_rounded,
                ontap: () {
                  signOut(context);
                }),
          ],
        ),
      ),
    );
  }

  Widget wierdPadding() => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 0.1),
        child: Container(height: 0.3, color: Colors.grey[300]),
      );
}
