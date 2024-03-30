import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/theme/button_decoration.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
  });

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AssetPath.bp2,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width,
          ),
          // CachedImageNetworkContainer(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height * 0.45,
          //   fit: BoxFit.contain,
          //
          //   decoration: AppBoxDecoration.getBoxDecoration(
          //     showShadow: false,
          //     shadowColor: Colors.grey.withOpacity(0.5),
          //     borderRadius: 0,
          //     spreadRadius: 1,
          //
          //   ),
          //   url: "https://graphicsfamily.com/wp-content/uploads/2020/11/Professional-Web-Banner-AD-in-Photoshop-1180x664.jpg",
          //   placeHolder: const SizedBox(
          //     height: 50,
          //     width: 50,
          //     child: CircularProgressIndicator(
          //       color: AppColors.fadedOrange,
          //     ),
          //   ),
          // ),
          DraggableScrollableSheet(
            snap: false,
            initialChildSize: 0.45,
            snapSizes: const [0.65],
            minChildSize: 0.45,
            maxChildSize: 0.75,
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
                      color: AppColors.porcelain, // Change the color as needed
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
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Product Name',
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.darkJungleGreen,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Sold: 248',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: AppColors.stormDust),
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(AssetPath.orangeUnLiked)
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
                                MyNavigator.pushNamed(GoPaths.myCart);
                                debugPrint("Button pressed $itemCount");
                              }, // Button label
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
      ),
    );
  }
}
