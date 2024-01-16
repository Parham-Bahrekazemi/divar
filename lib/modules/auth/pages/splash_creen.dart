import 'package:divar/helpers/widgets/button_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/modules/auth/controller/splash_controller.dart';
import 'package:divar/modules/auth/pages/login_page.dart';
import 'package:divar/modules/auth/pages/register_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (SplashController controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'اپلیکیشن آگهی هیتال',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const H(11),
                        Text(
                          'به اپلیکیشن آگهی هیتال خوش آمدید',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 66,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            ButtonWidget(
                              title: 'ثبت نام',
                              onPressed: () {
                                Get.to(const RegisterPage());
                              },
                            ),
                            const H(8),
                            ButtonWidget(
                              title: 'ورود',
                              onPressed: () {
                                Get.to(const LoginPage());
                              },
                              hasBorder: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
