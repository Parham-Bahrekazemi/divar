import 'package:divar/backend/model/provinces_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectProvinceWidget extends StatelessWidget {
  const SelectProvinceWidget(
      {super.key, required this.listProvince, required this.onSelected});

  final List<ProvincesModel> listProvince;

  final Function(ProvincesModel province) onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        height: 400,
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: listProvince.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onSelected(listProvince[index]);
                Get.back();
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      listProvince[index].name ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
