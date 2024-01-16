import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoBottomSheet extends StatelessWidget {
  const UserInfoBottomSheet({super.key, this.number, this.address});

  final String? number;
  final String? address;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 192,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.16),
              offset: const Offset(0, -3),
              blurRadius: 20,
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 27,
                    ),
                  ),
                ),
              ],
            ),
            const Text('شماره موبایل'),
            const H(6),
            Text(
              number ?? '',
              style: context.textTheme.titleLarge,
            ),
            const H(16),
            const Text('آدرس'),
            const H(6),
            Text(
              address ?? '',
              style: context.textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
