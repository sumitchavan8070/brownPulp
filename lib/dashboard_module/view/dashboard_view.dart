import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/components/bottom_navigation_bar.dart';
import 'package:project/dashboard_module/controller/dashboard_controller.dart';
import 'package:project/dashboard_module/controller/product_controller.dart';
import 'package:project/utilities/constants/cached_image_container.dart';
import 'package:project/utilities/constants/scroll_container.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';

final _getProductsController = Get.put(ProductController());
final _dashboardController = Get.put(DashBoardController());

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  // Uint8List imageBytes = your image as byte;

  final svgImages = [
    AssetPath.sofa,
    AssetPath.chair,
    AssetPath.desk,
  ];

  final images = [
    AssetPath.roomProduct1,
    AssetPath.roomProduct2,
    AssetPath.roomProduct3,
  ];

  final bpCards = [
    [
      AssetPath.bp1,
      AssetPath.bp2,
    ],
    [
      AssetPath.bp3,
      AssetPath.bp4,
    ]
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dashboardController.dashboard();
      _getProductsController.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                width: MediaQuery.of(context).size.width,
                decoration: AppBoxDecoration.getBoxDecoration(
                  showShadow: false,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "Explore What Your Home Needs",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.onyx,
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        MyNavigator.pushNamed(GoPaths.notification);
                      },
                      child: SvgPicture.asset(
                        AssetPath.notification,
                        width: 32, // Adjust width as needed
                        height: 32, // Adjust height as needed
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                decoration: AppBoxDecoration.getBorderBoxDecoration(
                  showShadow: false,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AssetPath.search),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.onyx,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        MyNavigator.pushNamed(GoPaths.chooseMockTestScreen);
                      },
                      child: Row(
                        children: [
                          Text(
                            "See all",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.plantation,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            AssetPath.arrow,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _dashboardController.obx((state) {
                return

                  Marquee(
                    maxHeight: 68,
                    offset: 40,
                    children: List.generate(
                      state?.categories?.length ?? 0,
                          (index) {
                        final item = state?.categories?[index];
                        return GestureDetector(
                          onTap:  () {
                            MyNavigator.pushNamed(GoPaths.chooseMockTestScreen);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.30,
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: AppBoxDecoration.getBoxDecoration(
                              showShadow: false,
                            ),
                            child:  CachedImageNetworkContainer(
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.42,
                              height: MediaQuery.of(context).size.height * 0.16,
                              decoration: AppBoxDecoration.getBoxDecoration(
                                showShadow: false,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                borderRadius: 0,
                                spreadRadius: 1,
                              ),
                              url: item?.image ?? '',
                              placeHolder: const SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  color: AppColors.fadedOrange,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
              }),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chair",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.onyx,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "See all",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.plantation,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            AssetPath.arrow,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              _getProductsController.obx(
                    (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(2 ?? 0, (index) {
                      final getData = state?.result?[index];
                      final imageData = bpCards[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          getData?.length ?? 0,
                              (index) {
                            final data = getData?[index];
                            final image = imageData[index];

                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              width: MediaQuery.of(context).size.width * 0.40,
                              decoration: AppBoxDecoration.getBoxDecoration(
                                showShadow: true,
                                borderRadius: 16,
                              ),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // CachedImageNetworkContainer(
                                      //   fit: BoxFit.cover,
                                      //   width: MediaQuery.of(context).size.width * 0.42,
                                      //   height: MediaQuery.of(context).size.height * 0.16,
                                      //   decoration: AppBoxDecoration.getBoxDecoration(
                                      //     showShadow: false,
                                      //     shadowColor: Colors.grey.withOpacity(0.5),
                                      //     borderRadius: 0,
                                      //     spreadRadius: 1,
                                      //   ),
                                      //   url: data?.image ?? '',
                                      //   placeHolder: const SizedBox(
                                      //     height: 50,
                                      //     width: 50,
                                      //     child: CircularProgressIndicator(
                                      //       color: AppColors.fadedOrange,
                                      //     ),
                                      //   ),
                                      // ),
                                      Image.asset(image),
                                      Text(
                                        data?.name ?? "",
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
                                            data?.price ?? "-",
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: AppColors.deepSeaGreen,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SvgPicture.asset(AssetPath.wishList),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  );
                },
                onLoading: const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.onyx,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "See all",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.plantation,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            AssetPath.arrow,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
                              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              decoration: AppBoxDecoration.getBoxDecoration(
                                showShadow: false,
                                color: AppColors.transparent,
                              ),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                clipBehavior: Clip.none,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.18,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: AppBoxDecoration.getBoxDecoration(
                                          showShadow: true,
                                          color: AppColors.white,
                                          blurRadius: 8,
                                        ),
                                        child: Padding(
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
                                      ),
                                    ],
                                  ),

                                  CachedImageNetworkContainer(
                                    width: MediaQuery.of(context).size.width * 0.38,
                                    height: MediaQuery.of(context).size.height * 0.17,
                                    fit: BoxFit.cover,
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
                                  // Image.network(
                                  //   data?.image ?? "",
                                  //   width: MediaQuery.of(context).size.width * 0.30,
                                  // )
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
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
                    child: CachedImageNetworkContainer(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.12,
                        fit: BoxFit.cover,
                        decoration: AppBoxDecoration.getBoxDecoration(
                          showShadow: true,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: 12,
                          spreadRadius: 1,
                        ),
                        url: "https://i.ibb.co/fkgMFxc/popular.png",
                        placeHolder: const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: AppColors.fadedOrange,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sale",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.fadedOrange,
                            fontSize: 30,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.fadedOrange,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'All chairs up to ',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.fadedOrange,
                                ),
                              ),
                              TextSpan(
                                text: '70% ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600, color: AppColors.fadedOrange, fontSize: 18),
                              ),
                              TextSpan(
                                text: 'off',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.fadedOrange,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rooms",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.onyx,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Furniture for every corners in your home",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.silverChalice,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final pngImages = images[index];
                    return Container(
                      height: 195,
                      width: 127,
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: AppBoxDecoration.getBoxDecoration(
                        showShadow: false,
                      ),
                      child: Image.asset(pngImages),
                    );
                  },
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar());
  }
}