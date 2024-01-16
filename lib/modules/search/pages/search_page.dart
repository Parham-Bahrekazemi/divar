import 'package:divar/helpers/widgets/ads_item_widget.dart';
import 'package:divar/helpers/widgets/loading_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/modules/search/controller/search_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
      init: SearchPageController(),
      builder: (SearchPageController controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const H(31),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 3),
                          blurRadius: 10,
                          color: const Color(0xff000000).withOpacity(0.1),
                        ),
                      ],
                    ),
                    height: 48,
                    child: TextFormField(
                      maxLines: 1,

                      // validator: widget.validator,
                      controller: controller.textSearchController,
                      // obscureText: ispassword ? obscure : false,
                      // keyboardType: widget.keyboardType ?? TextInputType.text,
                      // readOnly: widget.disibled,

                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xffECECEC),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'محصول مورد نظر خود را جستجو کنید',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Vazir',
                          color: Color(0xff959595),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.getAddByKeyWord();
                          },
                          child: Icon(
                            Iconsax.search_normal,
                            color: context.theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (controller.loading) const Expanded(child: LoadingWidget()),
                if (controller.adResponse != null)
                  controller.adResponse!.adModelList!.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text(
                              'آگهی مورد نظر یافت نشد',
                              style: context.textTheme.titleLarge,
                            ),
                          ),
                        )
                      : Expanded(
                          child: AdsItemWidget(
                              adModelList: controller.adResponse?.adModelList),
                        ),
              ],
            ),
          ),
        );
      },
    );
  }
}
