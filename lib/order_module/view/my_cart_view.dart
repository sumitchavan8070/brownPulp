import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/components/custom_app_bar.dart';
import 'package:project/order_module/controller/my_cart_controller.dart';
import 'package:project/order_module/controller/remove_from_my_cart_controller.dart';
import 'package:project/utilities/constants/cached_image_container.dart';
import 'package:project/utilities/constants/custom_dialogs.dart';
import 'package:project/utilities/constants/custom_error.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/theme/button_decoration.dart';

final _getMyCartController = Get.put(MyCartController());
final _removeFromMyCartController = Get.put(RemoveFromMyCartController());

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  late RxList<int> itemCount;
  RxBool removeOrderPopUp = false.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await _getMyCartController.getMyCart().then(
          (value) async {
            itemCount = List<int>.filled(_getMyCartController.state?.products?.length ?? 0, 1).obs;

            final product = _getMyCartController.state?.products ?? [];
            for (int i = 0; i < (product.length); i++) {
              var price = product[i].price;
              if (price is num) {
                itemCount[i] = 1;
              }
            }
          },
        );
      },
    );
  }

  void addAndSubtract(String value, int index, String? productId) {
    if (value == "add" && itemCount[index] < 10) {
      itemCount[index]++;
      calculateTotalPrice();
    }
    if (value == "sub" && itemCount[index] > 0) {
      if (itemCount[index] > 1) {
        itemCount[index]--;
        calculateTotalPrice();
      }

      if (itemCount[index] == 1) {
        Dialogs.removeOrderFromCart(
          context: context,
          removeFromCart: () {
            itemCount[index]--;
            calculateTotalPrice();
            removeOrderPopUp.value = true;
            _removeFromMyCartController.removeFromMyCart(
              productId: productId,
            );

            Navigator.of(context).pop();
          },
        );

        Future.delayed(
          const Duration(milliseconds: 5000),
          () async {
            if (removeOrderPopUp.value == false) {
              MyNavigator.pop();
            }
            removeOrderPopUp.value = false;
          },
        );
      }
    }
  }

  double calculateTotalPrice() {
    RxDouble totalPrice = 0.0.obs;
    final products = _getMyCartController.state?.products;
    if (products != null) {
      for (int i = 0; i < products.length; i++) {
        var price = products[i].price;
        if (price != null) {
          totalPrice.value += (price * itemCount[i]);
        }
      }
    }

    return totalPrice.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: "My Cart",
        bgColor: AppColors.white,
        leadingPopAll: true,
        isProfileView: false,
      ),
      body: _getMyCartController.obx(
        (state) {
          return state?.products?.isNotEmpty == false
              ? const Center(child: CustomError())
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state?.products?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = state?.products?[index];
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.14,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 18,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: AppBoxDecoration.getBoxDecoration(
                              color: AppColors.aquaHaze,
                              showShadow: false,
                              borderRadius: 12,
                            ),
                            child: Row(
                              children: [
                                CachedImageNetworkContainer(
                                  height: MediaQuery.of(context).size.height * 0.16,
                                  width: MediaQuery.of(context).size.height * 0.12,
                                  decoration: AppBoxDecoration.getBoxDecoration(
                                    showShadow: false,
                                    shadowColor: Colors.grey.withOpacity(
                                      0.5,
                                    ),
                                    borderRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                  url: item?.image ?? "",
                                  placeHolder: const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator(
                                        color: AppColors.fadedOrange,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                item?.name ?? "-",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context).textTheme.bodyLarge,
                                              ),
                                              Text(
                                                item?.subcategory ?? "-",
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: AppColors.black,
                                                    ),
                                              ),
                                              Text(
                                                "₹ ${item?.price ?? " - "}",
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      color: AppColors.tan,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    addAndSubtract(
                                                      "add",
                                                      index,
                                                      state?.products?[index].id.toString() ?? "",
                                                    );
                                                  },
                                                  child: SvgPicture.asset(
                                                    AssetPath.add,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  itemCount[index].toString(),
                                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                        color: AppColors.darkJungleGreen,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                ),
                                                const SizedBox(height: 4),
                                                GestureDetector(
                                                  onTap: () {
                                                    addAndSubtract(
                                                      "sub",
                                                      index,
                                                      state?.products?[index].id.toString() ?? "",
                                                    );
                                                  },
                                                  child: SvgPicture.asset(
                                                    AssetPath.sub,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.black.withOpacity(0.05),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Subtotal: ", // Display total price with 2 decimal places
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Obx(
                                        () => Text(
                                          "₹ ${calculateTotalPrice().round()}",
                                          // Display total price with 2 decimal places
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Transport fee: ", // Display total price with 2 decimal places
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        "₹ ${calculateTotalPrice().round()}", // Display total price with 2 decimal places
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              color: AppColors.aquaHaze,
                              thickness: 2,
                              endIndent: 18,
                              indent: 18,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total: ", // Display total price with 2 decimal places
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Obx(
                                    () => Text(
                                      "₹ ${calculateTotalPrice().round()}", // Display total price with 2 decimal places
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your button press logic here
                                },
                                // Button label
                                style: getElevatedButtonStyle(
                                  borderRadius: 40,
                                  foregroundColor: AppColors.roseEbony,
                                  backgroundColor: AppColors.roseEbony,
                                  elevation: 0,
                                ),
                                child: Text(
                                  "Check out",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.white,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
        },
        onLoading: const CircularProgressIndicator(),
        onEmpty: const Text("Empty"),
        onError: (error) {
          return Text("get error $error");
        },
      ),
    );
  }
}
