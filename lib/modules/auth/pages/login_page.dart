import 'package:divar/helpers/widgets/button_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/helpers/widgets/textfield_widget.dart';
import 'package:divar/modules/auth/controller/login_controller.dart';
import 'package:divar/modules/auth/pages/register_page.dart';
import 'package:divar/modules/auth/widgets/appbar_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (LoginController controller) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  const AuthAppbarWidget(
                    title: 'ورود',
                  ),
                  const H(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.5),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          TextFieldWidget(
                            hintText: 'شماره موبایل',
                            icon: Iconsax.mobile,
                            textEditingController:
                                controller.textNumberController,
                            validator: controller.mobileValidator,
                            keyboardType: TextInputType.phone,
                          ),
                          const H(9),
                          TextFieldWidget(
                            hintText: 'رمز عبور',
                            icon: Iconsax.mobile,
                            keyboardType: TextInputType.visiblePassword,
                            textEditingController:
                                controller.textPasswordController,
                            validator: controller.passwordValidator,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const H(19),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.5),
                    child: ButtonWidget(
                      title: 'ورود',
                      onPressed: () {
                        controller.login();
                      },
                      loading: controller.loading,
                    ),
                  ),
                  const H(21),
                  GestureDetector(
                    onTap: () {
                      Get.off(const RegisterPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'حساب کاربری ندارید؟',
                          style: Theme.of(context).textTheme.titleMedium?.apply(
                                color: const Color(0xff8C8C8C),
                              ),
                        ),
                        const W(4),
                        Text(
                          'ثبت نام کنید',
                          style: Theme.of(context).textTheme.titleMedium?.apply(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
