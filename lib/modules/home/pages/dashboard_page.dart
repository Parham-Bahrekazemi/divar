import 'package:divar/backend/model/ad_model.dart';
import 'package:divar/helpers/widgets/ads_item_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.adModelList});

  final List<AdModel>? adModelList;

  @override
  Widget build(BuildContext context) {
    bool listIsEmpty = adModelList?.isEmpty ?? true;
    return Scaffold(
      body: SafeArea(
        child: listIsEmpty
            ? Center(
                child: Text(
                  'آگهی مورد نظر یافت نشد',
                  style: context.textTheme.titleLarge,
                ),
              )
            : AdsItemWidget(
                adModelList: adModelList,
              ),
      ),
    );
  }
}
