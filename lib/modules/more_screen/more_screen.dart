import 'package:flutter/material.dart';
import 'package:maf_carrefour/constants/components.dart';
import 'package:maf_carrefour/constants/constans.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultbutton(
        function: () {
          signOut(context);
        },
        text: "logOut");
  }
}
