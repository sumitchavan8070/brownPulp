import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/components/custom_app_bar.dart';
import 'package:project/dashboard_module/controller/get_category_name_controller.dart';
import 'package:project/dashboard_module/controller/product_controller.dart';
import 'package:project/utilities/constants/cached_image_container.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';

final _getCategoryController = Get.put(GetCategoryController());

class ChooseCategory extends StatefulWidget {
  final String category;

  const ChooseCategory({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ChooseCategory> createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  RxInt completedIndex = 0.obs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _getProductsController.getProducts();
      _getCategoryController.getCategoryName(
          category: widget.category
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "Choose Category",
        isProfileView: false,
        bgColor: AppColors.zircon,
        actionOnTap: () {
          return;
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Grid View for mock tests
            _getCategoryController.obx((state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(state?.results?.length ?? 0, (index) {
                  final rowData = state?.results?[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      rowData?.length ?? 0,
                      (index) {
                        final data = rowData?[index];

                        return GestureDetector(
                          onTap: () {
                            MyNavigator.pushNamed(GoPaths.getDataFromCategoryName, extra: {
                              "category": data?.subcategory ?? 0,
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.28,
                            width: MediaQuery.of(context).size.width * 0.44,
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: AppBoxDecoration.getBoxDecoration(
                              showShadow: false,
                              color: AppColors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: CachedImageNetworkContainer(
                                    height: MediaQuery.of(context).size.height * 0.16,
                                    width: double.infinity,
                                    decoration: AppBoxDecoration.getBoxDecoration(
                                      showShadow: false,
                                      shadowColor: Colors.grey.withOpacity(0.5),
                                      borderRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                    url: data?.imageUrl ?? "",
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data?.subcategory ?? "",
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.darkJungleGreen,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Text(
                                        "Available Items: ${data?.categoryCount ?? 0}",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: AppColors.stormDust,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(AssetPath.star),
                                              const SizedBox(width: 4),
                                              Text(
                                                "4.9",
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: AppColors.stormDust,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          // Text(
                                          //   data?.price ?? "",
                                          //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          //         color: AppColors.deepSeaGreen,
                                          //         fontWeight: FontWeight.w600,
                                          //       ),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              );
            }),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
