import 'package:divar/backend/model/provinces_model.dart';
import 'package:divar/helpers/widgets/button_widget.dart';
import 'package:divar/helpers/widgets/loading_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/helpers/widgets/textfield_widget.dart';
import 'package:divar/modules/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SelectCityDialogWidget extends StatefulWidget {
  const SelectCityDialogWidget({
    super.key,
  });

  @override
  State<SelectCityDialogWidget> createState() => _SelectCityDialogWidgetState();
}

class _SelectCityDialogWidgetState extends State<SelectCityDialogWidget> {
  @override
  void initState() {
    Get.find<HomeController>().getProvinces();
    super.initState();
  }

  bool showCity = false;

  ProvincesModel? selectedProvince;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (HomeController controller) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: 507,
            width: 292,
            child: controller.provincesResponse == null
                ? const LoadingWidget()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const H(13),
                          Text(
                            showCity ? 'شهر ها' : 'استان ها',
                            style: context.textTheme.titleLarge,
                          ),
                          const H(8),
                          TextFieldWidget(
                            hintText: showCity
                                ? 'جستجو در شهر ها'
                                : 'جستجو در استان ها',
                            fillColor: const Color(0xffEFEFEF),
                            icon: Iconsax.search_normal,
                          ),
                          const H(18),
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              itemCount: controller.provincesResponse
                                      ?.listProvinces?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showCity = true;
                                          selectedProvince = controller
                                              .provincesResponse
                                              ?.listProvinces![index];
                                          controller
                                              .provincesResponse?.listProvinces
                                              ?.removeWhere((element) =>
                                                  element.id !=
                                                  controller
                                                      .provincesResponse
                                                      ?.listProvinces?[index]
                                                      .id);
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 7, top: 7),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xffF1F1F1)),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              controller
                                                      .provincesResponse
                                                      ?.listProvinces?[index]
                                                      .name ??
                                                  '',
                                              style: context
                                                  .textTheme.bodyMedium
                                                  ?.apply(color: Colors.black),
                                            ),
                                            RotatedBox(
                                              quarterTurns: showCity ? 3 : 0,
                                              child: const Icon(
                                                CupertinoIcons.chevron_back,
                                                color: Color(0xff959595),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //city
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Visibility(
                                        visible: showCity,
                                        child: SizedBox(
                                          height: 250,
                                          child: ListView.builder(
                                            itemCount: controller
                                                    .provincesResponse
                                                    ?.listProvinces?[index]
                                                    .cities
                                                    ?.length ??
                                                0,
                                            itemBuilder: (BuildContext context,
                                                int indexCity) {
                                              var city = controller
                                                  .provincesResponse
                                                  ?.listProvinces?[index]
                                                  .cities?[indexCity];
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.sortByLocation(
                                                    province: null,
                                                    city: city,
                                                  );
                                                  Get.back();
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 7, top: 7),
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color: Color(
                                                              0xffF1F1F1)),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        city?.name ?? '',
                                                        style: context.textTheme
                                                            .bodyMedium
                                                            ?.apply(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      const Icon(
                                                        CupertinoIcons
                                                            .chevron_back,
                                                        color:
                                                            Color(0xff959595),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const H(32),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ButtonWidget(
                                  title: 'انصراف',
                                  onPressed: () {
                                    Get.back();
                                  },
                                  hasBorder: true,
                                ),
                              ),
                              const W(13),
                              Expanded(
                                child: ButtonWidget(
                                  title: 'تایید',
                                  onPressed: () {
                                    controller.sortByLocation(
                                      province: selectedProvince,
                                      city: null,
                                    );
                                    Get.back();
                                  },
                                ),
                              ),
                            ],
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
