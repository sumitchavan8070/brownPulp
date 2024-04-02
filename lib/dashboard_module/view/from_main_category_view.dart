import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/components/custom_app_bar.dart';
import 'package:project/dashboard_module/controller/get_data_from_main_category_controller.dart';
import 'package:project/utilities/constants/cached_image_container.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';

final _getCategoryDataController = Get.put(GetCategoryDataController());

class GetDataFromCategoryName extends StatefulWidget {
  final String category;

  const GetDataFromCategoryName({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<GetDataFromCategoryName> createState() => _GetDataFromCategoryNameState();
}

class _GetDataFromCategoryNameState extends State<GetDataFromCategoryName> {
  RxInt completedIndex = 0.obs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _getProductsController.getProducts();
      _getCategoryDataController.getCategoryData(
        category: widget.category,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "${widget.category} Products",
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
            _getCategoryDataController.obx((state) {
              debugPrint("here is getCategoryData data  ${state?.result}");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(state?.result?.length ?? 0, (index) {
                  final rowData = state?.result?[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      rowData?.length ?? 0,
                      (index) {
                        final data = rowData?[index];

                        return GestureDetector(
                          onTap: () {
                            MyNavigator.pushNamed(GoPaths.productDetailView, extra: {
                              "productId": data?.id ?? 0,
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
                                    url: data?.image ?? "",
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
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text(
                                        data?.subcategory ?? "",
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.darkJungleGreen,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "MRP  : ${data?.mrp ?? 0}",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: AppColors.plantation,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Column(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Brand : ',
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                ),
                                                TextSpan(
                                                    text: data?.brand?.trim() ?? "-",
                                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                          color: AppColors.stormDust,
                                                        )),
                                              ],
                                            ),
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
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
