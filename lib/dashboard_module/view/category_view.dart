import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/components/custom_app_bar.dart';
import 'package:project/dashboard_module/controller/product_controller.dart';
import 'package:project/utilities/constants/cached_image_container.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';

final _getProductsController = Get.put(ProductController());

class ChooseMockTestScreen extends StatefulWidget {
  const ChooseMockTestScreen({Key? key}) : super(key: key);

  @override
  State<ChooseMockTestScreen> createState() => _ChooseMockTestScreenState();
}

class _ChooseMockTestScreenState extends State<ChooseMockTestScreen> {
  final dynamicQuizApiList = [
    "https://run.mocky.io/v3/9f42f0bb-cde5-45bd-95c3-94a6c1cbb0fd",
    "https://run.mocky.io/v3/5add3902-7fc1-48dd-8ccc-24837f6cce06",
    "https://run.mocky.io/v3/f182d03e-562d-41d5-9894-a247307775b0",
    "https://run.mocky.io/v3/240cfd1c-4738-4195-b971-f6a714f08e78",
    "https://run.mocky.io/v3/d303fe66-e401-446a-a0be-d2eeb6bcbaa0",
    "https://run.mocky.io/v3/0b47d609-8d14-4e09-95a5-17b30e0652dc",
    "https://run.mocky.io/v3/240cfd1c-4738-4195-b971-f6a714f08e78",
    "https://run.mocky.io/v3/5add3902-7fc1-48dd-8ccc-24837f6cce06",
  ];

  late List<int> testStates = List.generate(dynamicQuizApiList.length, (index) => 0);

  RxInt completedIndex = 0.obs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProductsController.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "Choose Mock Test",
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
            _getProductsController.obx((state) {
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data?.name ?? "",
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.darkJungleGreen,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Text(
                                        "Item: 248",
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
                                          Text(
                                            data?.price ?? "",
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: AppColors.deepSeaGreen,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
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
