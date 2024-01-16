import 'package:divar/backend/model/provinces_model.dart';
import 'package:divar/helpers/widgets/button_widget.dart';
import 'package:divar/helpers/widgets/loading_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';
import 'package:divar/helpers/widgets/textfield_widget.dart';
import 'package:divar/modules/auth/controller/register_controller.dart';
import 'package:divar/modules/auth/pages/login_page.dart';
import 'package:divar/modules/auth/widgets/appbar_widget.dart';
import 'package:divar/modules/auth/widgets/select_city_widget.dart';
import 'package:divar/modules/auth/widgets/select_province_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class RegisterPage extends StatelessWidget {
  static const String nameRoute = '/registerPage';
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (RegisterController controller) {
          return Scaffold(
            body: SafeArea(
              child: controller.provincesResponse == null
                  ? const LoadingWidget()
                  : SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const AuthAppbarWidget(
                            title: 'ثبت نام',
                          ),
                          const H(15),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.5),
                            child: Form(
                              key: controller.fromKey,
                              child: Column(
                                children: [
                                  TextFieldWidget(
                                    hintText: 'نام و نام خانوادگی',
                                    icon: Iconsax.user,
                                    textEditingController:
                                        controller.txtNameController,
                                    validator: controller.nameValidator,
                                    keyboardType: TextInputType.name,
                                  ),
                                  const H(9),
                                  TextFieldWidget(
                                    hintText: 'شماره موبایل',
                                    icon: Iconsax.mobile,
                                    textEditingController:
                                        controller.txtMobileController,
                                    validator: controller.mobileValidator,
                                    keyboardType: TextInputType.phone,
                                  ),
                                  const H(9),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SelectProvinceWidget(
                                                  listProvince: controller
                                                      .provincesResponse!
                                                      .listProvinces!,
                                                  onSelected: (
                                                    ProvincesModel province,
                                                  ) =>
                                                      controller
                                                          .onSelectProvince(
                                                              province),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(13),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .dividerColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  controller.selectedProvince ==
                                                          null
                                                      ? 'استان'
                                                      : controller
                                                              .selectedProvince
                                                              ?.name ??
                                                          '',
                                                  style: controller
                                                              .selectedProvince ==
                                                          null
                                                      ? TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor,
                                                          fontSize: 14,
                                                        )
                                                      : const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                ),
                                                const Spacer(),
                                                Icon(
                                                  CupertinoIcons.chevron_down,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const W(19),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (controller.selectedProvince !=
                                                null) {
                                              FocusScope.of(context).unfocus();
                                              showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return SelectCityWidget(
                                                    province: controller
                                                        .selectedProvince!,
                                                    onSelected: (
                                                      CitiesModel city,
                                                    ) =>
                                                        controller
                                                            .onSelectCity(city),
                                                  );
                                                },
                                              );
                                            } else {
                                              errorMessage(
                                                  'لطفا اول استان خود را انتخاب کنید');
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(13),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .dividerColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  controller.selectedCity ==
                                                          null
                                                      ? 'شهر'
                                                      : controller.selectedCity
                                                              ?.name ??
                                                          '',
                                                  style: controller
                                                              .selectedCity ==
                                                          null
                                                      ? TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor,
                                                          fontSize: 14,
                                                        )
                                                      : const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                ),
                                                const Spacer(),
                                                Icon(
                                                  CupertinoIcons.chevron_down,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const H(9),
                                  TextFieldWidget(
                                    hintText: 'آدرس',
                                    maxlines: 3,
                                    textEditingController:
                                        controller.txtAddressController,
                                    validator: controller.addressValidator,
                                  ),
                                  const H(9),
                                  TextFieldWidget(
                                    hintText: 'رمز عبور',
                                    icon: Iconsax.mobile,
                                    keyboardType: TextInputType.visiblePassword,
                                    textEditingController:
                                        controller.txtPassworController,
                                    validator: controller.passwordValidator,
                                  ),
                                  const H(9),
                                  TextFieldWidget(
                                    hintText: 'تکرار رمز عبور',
                                    icon: Iconsax.mobile,
                                    keyboardType: TextInputType.visiblePassword,
                                    textEditingController: controller
                                        .txtPasswordConfirmationController,
                                    validator:
                                        controller.passwordConfirmValidator,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const H(19),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.5),
                            child: ButtonWidget(
                              title: 'ثبت نام',
                              onPressed: () {
                                controller.register();
                              },
                              loading: controller.loading,
                            ),
                          ),
                          const H(21),
                          GestureDetector(
                            onTap: () {
                              Get.off(const LoginPage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'حساب کاربری دارید؟',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.apply(
                                        color: const Color(0xff8C8C8C),
                                      ),
                                ),
                                const W(4),
                                Text(
                                  'وارد شوید',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.apply(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
