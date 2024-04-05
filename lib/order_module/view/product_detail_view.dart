import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/order_module/controller/add_to_cart_controller.dart';
import 'package:project/order_module/controller/product_detail_controller.dart';
import 'package:project/utilities/constants/cached_image_container.dart';
import 'package:project/utilities/constants/custom_dialogs.dart';
import 'package:project/utilities/constants/global_var.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/theme/button_decoration.dart';

final _getProductDetailController = Get.put(ProductDetailController());
final _addToCartController = Get.put(AddToCartController());

class ProductDetailView extends StatefulWidget {
  final int productId;

  const ProductDetailView({super.key, required this.productId});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  RxInt itemCount = 0.obs;

  void addAndSubtract(String value) {
    if (value == "add" && itemCount.value < 10) {
      itemCount.value++;
    } else if (value == "sub" && itemCount.value > 0) {
      itemCount.value--;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getProductDetailController.getProductDetail(id: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBody: true,
      body: _getProductDetailController.obx((state) {
        return Stack(
          children: [
            // Image.asset(
            //   state?.result?.image ?? AssetPath.roomProduct1,
            //   fit: BoxFit.cover,
            //   height: MediaQuery.of(context).size.height * 0.60,
            //   width: MediaQuery.of(context).size.width,
            // ),
            CachedImageNetworkContainer(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.45,
              fit: BoxFit.fitWidth,
              decoration: AppBoxDecoration.getBoxDecoration(
                color: AppColors.transparent,
                showShadow: false,
                borderRadius: 0,
                spreadRadius: 1,
              ),
              url: state?.result?.image ?? AssetPath.roomProduct1,
              placeHolder: const SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: AppColors.fadedOrange,
                ),
              ),
            ),
            DraggableScrollableSheet(
              snap: false,
              initialChildSize: 0.58,
              snapSizes: const [0.65],
              minChildSize: 0.58,
              maxChildSize: 0.80,
              expand: true,
              builder: (context, scrollController) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.transparent, // Change the color as needed
                        spreadRadius: 4,
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5,
                            width: 36,
                            decoration: AppBoxDecoration.getBoxDecoration(
                              borderRadius: 12,
                              color: AppColors.shipGrey.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state?.result?.name ?? "",
                                              maxLines: 2,
                                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.darkJungleGreen,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Sold: 248',
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: AppColors.stormDust,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        child: SvgPicture.asset(
                                          AssetPath.orangeUnLiked,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AssetPath.star,
                                        height: 18,
                                        width: 18,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '4.3 (4253 comment)',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: AppColors.darkJungleGreen,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Detail',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: AppColors.darkJungleGreen,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Orb upholstered chair is made of metal legs with powder coated finish. Electrostatic seat cushion, legs can be removed. See more.....',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.stardust,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  height: 36,
                                  width: 90,
                                  margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                  decoration: AppBoxDecoration.getBoxDecoration(
                                    showShadow: true,
                                    borderRadius: 10,
                                    color: AppColors.white,
                                  ),
                                  child: Obx(
                                    () {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                addAndSubtract("sub");
                                              },
                                              child: SvgPicture.asset(AssetPath.sub)),
                                          Text(itemCount.toString()),
                                          GestureDetector(
                                              onTap: () {
                                                addAndSubtract("add");
                                              },
                                              child: SvgPicture.asset(AssetPath.add)),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your button press logic here
                                  debugPrint(
                                      "userId  ${state?.result?.id.toString()}");

                                  _addToCartController
                                      .addToCart(
                                          productId: state?.result?.id.toString() ?? "",
                                          userId: GlobalVars.userId.toString() ?? 7)
                                      .then((value) {
                                    if (value == 0) {
                                      debugPrint("item not added");
                                    }

                                    if (value == 1) {
                                      Dialogs.showAddToCartSuccessDialog(context);
                                      Future.delayed(const Duration(milliseconds: 1500), () async {
                                        MyNavigator.pushNamed(GoPaths.myCart);
                                      });
                                    }
                                  });
                                }, // Button label
                                style: getElevatedButtonStyle(
                                  borderRadius: 40,
                                  foregroundColor: AppColors.roseEbony,
                                  backgroundColor: AppColors.roseEbony,
                                  elevation: 0,
                                ),
                                child: Text(
                                  "Continue",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.white,
                                      ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
