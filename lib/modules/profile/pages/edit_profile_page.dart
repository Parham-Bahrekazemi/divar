import 'package:divar/backend/model/provinces_model.dart';
import 'package:divar/backend/model/user_model.dart';
import 'package:divar/helpers/widgets/appbar_widget.dart';
import 'package:divar/helpers/widgets/button_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';
import 'package:divar/helpers/widgets/textfield_widget.dart';
import 'package:divar/modules/auth/widgets/select_city_widget.dart';
import 'package:divar/modules/auth/widgets/select_province_widget.dart';
import 'package:divar/modules/profile/controller/edit_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key, required this.userModel});

  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(
          userModel.province!, userModel.cityId!, userModel.name!),
      builder: (EditProfileController controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    const AppbarWidget(title: 'ویرایش پروفایل'),
                    const H(45.5),
                    GestureDetector(
                      onTap: () {
                        controller.selectImage();
                      },
                      child: controller.file != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                controller.file!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : userModel.avatar != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    userModel.avatar!,
                                    width: 100,
                                    height: 100,
                                  ))
                              : Center(
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color(0xffECECEC),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Iconsax.gallery,
                                        color: Color(0xff959595),
                                      ),
                                    ),
                                  ),
                                ),
                    ),
                    const H(15),
                    Text(
                      'انتخاب عکس پروفایل',
                      style: context.textTheme.bodyMedium,
                    ),
                    const H(40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: Column(
                        children: [
                          TextFieldWidget(
                            hintText: 'نام و نام خانوادگی',
                            textEditingController:
                                controller.textNameController,
                            validator: controller.nameValidator,
                          ),
                          const H(12),
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
                                                  .onSelectProvince(province),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Theme.of(context).dividerColor,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          controller.selectedProvince?.name ??
                                              '',
                                          style: controller.selectedProvince ==
                                                  null
                                              ? TextStyle(
                                                  color: Theme.of(context)
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
                                          color: Theme.of(context).hintColor,
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
                                    if (controller.selectedProvince != null) {
                                      FocusScope.of(context).unfocus();
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SelectCityWidget(
                                            province:
                                                controller.selectedProvince!,
                                            onSelected: (
                                              CitiesModel city,
                                            ) =>
                                                controller.onSelectCity(city),
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
                                        color: Theme.of(context).dividerColor,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          controller.selectedCity?.name ?? '',
                                          style: controller.selectedCity == null
                                              ? TextStyle(
                                                  color: Theme.of(context)
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
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const H(12),
                          TextFieldWidget(
                            hintText: 'آدرس',
                            maxlines: 3,
                            textEditingController:
                                controller.textAddressController,
                          ),
                          const H(15),
                          ButtonWidget(
                            title: 'ویرایش',
                            onPressed: () {
                              controller.editProfile();
                            },
                            loading: controller.loading,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
