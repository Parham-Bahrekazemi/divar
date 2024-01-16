import 'package:divar/backend/model/ad_model.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/modules/ads_detail/pages/ads_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdsItemWidget extends StatelessWidget {
  const AdsItemWidget({
    super.key,
    required this.adModelList,
    this.trash = false,
    this.onDelete,
  });

  final List<AdModel>? adModelList;

  final bool? trash;

  final Function(int adId)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26, top: 31, bottom: 10),
      child: ListView.builder(
        itemCount: adModelList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    AdsDetailPage(
                      adId: adModelList![index].id!,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 22),
                  height: 107,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 3),
                        blurRadius: 10,
                        color: const Color(0xff000000).withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 8, bottom: 8, top: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                adModelList?[index].image ?? '',
                                fit: BoxFit.cover,
                                width: 94,
                                height: 94,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const H(8),
                              SizedBox(
                                width: 190,
                                child: Text(
                                  adModelList![index].title ?? '',
                                  style: context.textTheme.bodyMedium
                                      ?.apply(color: Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const H(4),
                              Row(
                                children: <Widget>[
                                  Text(
                                    adModelList![index].price ?? '',
                                    style: context.textTheme.titleMedium
                                        ?.apply(color: Colors.black),
                                  ),
                                  const W(3),
                                  Text(
                                    'تومان',
                                    style: context.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        child: Text(
                          adModelList![index].createdAt ?? '',
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (trash != null && trash == true)
                Positioned(
                  top: 7,
                  left: 5,
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: GestureDetector(
                      onTap: () {
                        if (onDelete != null) {
                          onDelete!(adModelList![index].id!);
                        }
                      },
                      child: const Icon(
                        Iconsax.trash,
                        color: Color(0xff292D32),
                        size: 22,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
