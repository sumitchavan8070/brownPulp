import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/components/custom_app_bar.dart';
import 'package:project/order_module/controller/my_cart_controller.dart';
import 'package:project/utilities/constants/cached_image_container.dart';
import 'package:project/utilities/constants/global_var.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/theme/button_decoration.dart';

// _orderCancelController = Get.put(OrderCancelController());
final _getMyCartController = Get.put(MyCartController());

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

final data = [
  {
    "title": "Nolan Chair 123",
    "subtitle": "Chair",
    "price": 300,
    "image": AssetPath.bp1,
  },
  {
    "title": "Nolan Chair 123",
    "subtitle": "Chair",
    "price": 520,
    "image": AssetPath.bp2,
  },
  {
    "title": "Nolan Chair 123",
    "subtitle": "Chair",
    "price": 150,
    "image": AssetPath.bp3,
  },
  {
    "title": "Nolan Chair 123",
    "subtitle": "Chair",
    "price": 154,
    "image": AssetPath.bp4,
  },
];

class _MyCartState extends State<MyCart> {
  RxList<int> itemCount = List<int>.filled(data.length, 1).obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMyCartController.getMyCart(
      userId: GlobalVars.userId,
    );
    final data = _getMyCartController.state?.products ?? [];
    for (int i = 0; i < (data.length ?? 0); i++) {
      final sort = data[i].price?.split("₹").first;
      var price = num.tryParse(sort.toString());
      if (price is num) {
        itemCount[i] = 1;
      }
    }
  }

  void addAndSubtract(String value, int index) {
    if (value == "add" && itemCount[index] < 10) {
      itemCount[index]++;
    } else if (value == "sub" && itemCount[index] > 0) {
      itemCount[index]--;
    }
  }

  double calculateTotalPrice() {
    RxDouble totalPrice = 0.0.obs;
    final item = _getMyCartController.state?.products ?? [];
    for (int i = 0; i < (item.length ?? 0); i++) {
      final sort = item[i].price?.split("₹").first;
      var price = num.tryParse(sort.toString());
      if (price is num) {
        totalPrice.value += price * itemCount[i].toDouble();
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
        body: _getMyCartController.obx((state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state?.products?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = state?.products?[index];
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                              shadowColor: Colors.grey.withOpacity(0.5),
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
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                          item?.price ?? "-",
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: AppColors.deepSeaGreen,
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
                                              addAndSubtract("add", index);
                                            },
                                            child: SvgPicture.asset(
                                              AssetPath.add,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            itemCount[index].toString(),
                                          ),
                                          const SizedBox(height: 4),
                                          GestureDetector(
                                            onTap: () {
                                              addAndSubtract("sub", index);
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
                              "\$${calculateTotalPrice().round()}", // Display total price with 2 decimal places
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
                          Obx(
                            () => Text(
                              "\$${calculateTotalPrice().round()}", // Display total price with 2 decimal places
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
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
                          "\$${calculateTotalPrice().round()}", // Display total price with 2 decimal places
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
                      foregroundColor: AppColors.plantation,
                      backgroundColor: AppColors.plantation,
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
          );
        }));
  }
}
