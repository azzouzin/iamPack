import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../data/models/product_model.dart';
import '../modules/base/controllers/base_controller.dart';
import '../routes/app_pages.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.PRODUCT_DETAILS, arguments: {"product": product}),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF1FA),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image.asset(
                    product.images!.first,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ).animate().slideX(
                        duration: const Duration(milliseconds: 200),
                        begin: 1,
                        curve: Curves.easeInSine,
                      ),
                ),
                /* Positioned(
                  left: 15.w,
                  bottom: 20.h,
                  child: GetBuilder<BaseController>(
                    id: 'FavoriteButton',
                    builder: (controller) => GestureDetector(
                      onTap: () => controller.onFavoriteButtonPressed(
                          productId: product.id!),
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          product.isFavorite!
                              ? Constants.favFilledIcon
                              : Constants.favOutlinedIcon,
                          color:
                              product.isFavorite! ? null : theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ).animate().fade(),
              */
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                Text(product.name!,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.w600))
                    .animate()
                    .fade()
                    .slideY(
                      duration: const Duration(milliseconds: 200),
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
                Spacer(),
                Text(product.embalage ?? "", style: theme.textTheme.bodyMedium)
                    .animate()
                    .fade()
                    .slideY(
                      duration: const Duration(milliseconds: 200),
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
              ],
            ),
            5.verticalSpace,
            product.promoPrice != null ? promoPrice(theme) : normalPrice(theme),
          ],
        ),
      ),
    );
  }

  Widget promoPrice(ThemeData theme) {
    return Row(
      children: [
        Text('DZ ${product.promoPrice}', style: theme.textTheme.displaySmall)
            .animate()
            .fade()
            .slideY(
              duration: const Duration(milliseconds: 200),
              begin: 2,
              curve: Curves.easeInSine,
            ),
        //  Spacer(),
        product.promoPrice == null
            ? Container()
            : Text(
                ' DZ ${product.price.toString()}',
                style: theme.textTheme.bodyMedium!
                    .copyWith(decoration: TextDecoration.lineThrough),
              ).animate().fade().slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 1,
                  curve: Curves.easeInSine,
                ),
      ],
    );
  }

  Widget normalPrice(ThemeData theme) {
    return Row(
      children: [
        Text('DZ ${product.price}', style: theme.textTheme.displaySmall)
            .animate()
            .fade()
            .slideY(
              duration: const Duration(milliseconds: 200),
              begin: 2,
              curve: Curves.easeInSine,
            ),
      ],
    );
  }
}
