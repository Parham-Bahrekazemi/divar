import 'package:divar/helpers/widgets/loading_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/modules/ads_detail/controller/ads_detail_controller.dart';
import 'package:divar/modules/ads_detail/widgets/user_info_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdsDetailPage extends StatelessWidget {
  const AdsDetailPage({super.key, required this.adId});

  final int adId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdsDetailController>(
      init: AdsDetailController(adId.toString()),
      builder: (AdsDetailController controller) {
        return Scaffold(
          body: SafeArea(
            child: controller.adsDetailResponse == null
                ? const LoadingWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                controller
                                        .adsDetailResponse?.adsDetail?.image ??
                                    '',
                                height: 323,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 12,
                              child: Container(
                                width: 37,
                                height: 37,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(
                                      Iconsax.arrow_left,
                                      color: Color(0xff292D32),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 12,
                              child: GestureDetector(
                                onTap: () {
                                  controller.bookmark(adId);
                                },
                                child: Container(
                                  width: 37,
                                  height: 37,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Iconsax.archive_add,
                                      color: Color(0xff292D32),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 20),
                        child: Text(
                          controller.adsDetailResponse?.adsDetail?.title ?? '',
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 20),
                        child: Text(
                          'توضحیات',
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 20, top: 6, left: 20),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 13, right: 13, bottom: 13),
                              child: Text(
                                controller.adsDetailResponse?.adsDetail
                                        ?.description ??
                                    '',
                                style: context.textTheme.bodyMedium,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 20, top: 16, left: 20),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: <Widget>[
                              const W(15),
                              Text(
                                'قیمت',
                                style: context.textTheme.bodyMedium,
                              ),
                              const Spacer(),
                              Text(
                                controller
                                        .adsDetailResponse?.adsDetail?.price ??
                                    '',
                                style: context.textTheme.titleLarge,
                              ),
                              const W(4.5),
                              Text(
                                'تومان',
                                style: context.textTheme.bodyMedium,
                              ),
                              const W(12),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 110),
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              context: context,
                              builder: (BuildContext context) {
                                return UserInfoBottomSheet(
                                  number: controller.adsDetailResponse
                                          ?.adsDetail?.contactInfo?.mobile ??
                                      '',
                                  address: controller.adsDetailResponse
                                          ?.adsDetail?.contactInfo?.address ??
                                      '',
                                );
                              },
                            );
                          },
                          color: Theme.of(context).colorScheme.primary,
                          minWidth: double.infinity,
                          height: 43,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'اطلاعات تماس',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              W(9),
                              Icon(
                                Iconsax.call,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      const H(28),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
