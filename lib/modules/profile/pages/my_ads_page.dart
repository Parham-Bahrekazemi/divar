import 'package:divar/helpers/widgets/ads_item_widget.dart';
import 'package:divar/helpers/widgets/appbar_widget.dart';
import 'package:divar/helpers/widgets/loading_widget.dart';
import 'package:divar/modules/profile/controller/my_ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAdsPage extends StatelessWidget {
  const MyAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAdsController>(
      init: MyAdsController(),
      builder: (MyAdsController controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const AppbarWidget(title: 'آگهی های من'),
                controller.adResponse == null
                    ? const Expanded(child: LoadingWidget())
                    : controller.adResponse!.adModelList!.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text(
                                'آگهی توسط شما ثبت نشده است',
                                style: context.textTheme.titleLarge,
                              ),
                            ),
                          )
                        : Expanded(
                            child: AdsItemWidget(
                              adModelList: controller.adResponse?.adModelList,
                              trash: true,
                              onDelete: (int adId) {
                                controller.deleteAd(adId);
                              },
                            ),
                          ),
              ],
            ),
          ),
        );
      },
    );
  }
}
