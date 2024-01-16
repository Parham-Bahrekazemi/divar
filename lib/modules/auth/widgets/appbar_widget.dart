import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AuthAppbarWidget extends StatelessWidget {
  const AuthAppbarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Iconsax.arrow_left,
            ),
          ),
        ],
      ),
    );
  }
}
