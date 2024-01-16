import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 15,
              color: const Color(0xff000000).withOpacity(0.071)),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
          ),
          Text(
            title,
            style: context.textTheme.titleLarge,
          ),
          Positioned(
            left: 16,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Iconsax.arrow_left),
            ),
          ),
        ],
      ),
    );
  }
}
