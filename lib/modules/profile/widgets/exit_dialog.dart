import 'package:divar/helpers/widgets/button_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/modules/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 300,
        height: 141,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 23, right: 25),
              child: Text(
                'آیا از خروج حساب مطمئنید؟',
                style: context.textTheme.titleLarge,
              ),
            ),
            const H(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ButtonWidget(
                      title: 'انصراف',
                      onPressed: () {
                        Get.back();
                      },
                      hasBorder: true,
                    ),
                  ),
                  const W(10),
                  Expanded(
                    child: ButtonWidget(
                      title: 'بله',
                      onPressed: () {
                        Get.find<ProfileController>().logout();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
