import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/components/custom_app_bar.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/theme/button_decoration.dart';

// _orderCancelController = Get.put(OrderCancelController());
// _getCurrentOrderList = Get.put(GetCurrentOrderList());

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

  void addAndSubtract(String value, int index) {
    if (value == "add" && itemCount[index] < 10) {
      itemCount[index]++;
    } else if (value == "sub" && itemCount[index] > 0) {
      itemCount[index]--;
    }
  }

  double calculateTotalPrice() {
    RxDouble totalPrice = 0.0.obs;

    for (int i = 0; i < data.length; i++) {
      var price = data[i]["price"];
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
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
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
                    Image.asset(item["image"].toString()),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6),
                                Text(
                                  item["title"].toString(),
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item["subtitle"].toString(),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColors.black,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "\$${item["price"]}",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.deepSeaGreen, fontWeight: FontWeight.w600, fontSize: 20),
                                ),
                              ],
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
                                      child: SvgPicture.asset(AssetPath.add),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(itemCount[index].toString()),
                                    const SizedBox(height: 4),
                                    GestureDetector(
                                        onTap: () {
                                          addAndSubtract("sub", index);
                                        },
                                        child: SvgPicture.asset(AssetPath.sub)),
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
          const Divider(
            height: 1,
            color: AppColors.aquaHaze,
            thickness: 2,
            endIndent: 18,
            indent: 18,
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
                "Continue",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
