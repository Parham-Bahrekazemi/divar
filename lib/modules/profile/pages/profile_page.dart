import 'package:divar/helpers/widgets/loading_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/modules/profile/controller/profile_controller.dart';
import 'package:divar/modules/profile/pages/bookmark_page.dart';
import 'package:divar/modules/profile/pages/edit_profile_page.dart';
import 'package:divar/modules/profile/pages/my_ads_page.dart';
import 'package:divar/modules/profile/widgets/exit_dialog.dart';
import 'package:divar/modules/profile/widgets/profile_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (ProfileController controller) {
          return Scaffold(
            body: SafeArea(
              child: controller.userModel == null
                  ? const LoadingWidget()
                  : Column(
                      children: <Widget>[
                        const H(45.5),
                        controller.userModel?.avatar != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  controller.userModel?.avatar ?? '',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
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
                        const H(15),
                        Text(
                          controller.userModel?.name ?? '',
                          style: context.textTheme.titleSmall,
                        ),
                        const H(15),
                        ProfileItemWidget(
                          icon: Iconsax.user_edit,
                          title: 'ویرایش پروفایل',
                          onTap: () {
                            Get.to(
                              EditProfilePage(
                                userModel: controller.userModel!,
                              ),
                            );
                          },
                        ),
                        ProfileItemWidget(
                          icon: Iconsax.task_square,
                          title: 'آگهی های من',
                          onTap: () {
                            Get.to(
                              const MyAdsPage(),
                            );
                          },
                        ),
                        ProfileItemWidget(
                          icon: Iconsax.save_2,
                          title: 'نشان ها',
                          onTap: () {
                            Get.to(const BookMarkPage());
                          },
                        ),
                        ProfileItemWidget(
                          icon: Iconsax.logout,
                          title: 'خروج از حساب',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const ExitDialog(),
                            );
                          },
                        ),
                      ],
                    ),
            ),
          );
        });
  }
}
