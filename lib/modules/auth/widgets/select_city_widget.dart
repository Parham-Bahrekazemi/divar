import 'package:divar/backend/model/provinces_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCityWidget extends StatelessWidget {
  const SelectCityWidget(
      {super.key, required this.province, required this.onSelected});

  final ProvincesModel province;

  final Function(CitiesModel cityModel) onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      height: 400,
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: province.cities?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onSelected(province.cities![index]);
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
                    province.cities![index].name ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
