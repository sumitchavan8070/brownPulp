import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/dashboard_module/components/components.dart';
import 'package:project/utilities/constants/scroll_container.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';

class CustomSliverAppBar extends StatefulWidget {
  const CustomSliverAppBar({super.key});

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  final svgImages = [
    AssetPath.chair,
    AssetPath.desk,
    AssetPath.sofa,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            width: MediaQuery.of(context).size.width,
            decoration: AppBoxDecoration.getBoxDecoration(
              showShadow: false,
              color: Colors.grey.shade200,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Explore What Your Home Needs",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                ),
                SvgPicture.asset(
                  AssetPath.notification,
                  width: 32, // Adjust width as needed
                  height: 32, // Adjust height as needed
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
          CategoryComponent(
            title: "Categories",
            subTitle: "View All",
            onTap: () {
              debugPrint("here is the tapped button ");
            },
          ),
          Marquee(
            maxHeight: 60,
            offset: 5 * 8,
            children: List.generate(svgImages.length, (index) {
              final assetName = svgImages[index];
              return Container(
                height: 56,
                width: 125,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: AppBoxDecoration.getBorderBoxDecoration(
                  showShadow: false,
                ),
                child: SvgPicture.asset(
                  assetName,
                ),
              );
            }),
          )
        ],
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.white,
      //1
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColors.white,
            pinned: true,
            expandedHeight: 108.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16.0, top: 16),
              title: Row(
                children: [
                  Flexible(
                    child: Text(
                      "Explore What Your Home Needs",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.onyx,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SvgPicture.asset(
                      AssetPath.notification,
                      width: 24, // Adjust width as needed
                      height: 24, // Adjust height as needed
                    ),
                  ),
                ],
              ),
            ),
            elevation: 0, // Set elevation to 0 to hide it
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return ListTile(
                  leading: Container(padding: const EdgeInsets.all(8), width: 100, child: Placeholder()),
                  title: Text('Place ${index + 1}', textScaleFactor: 2),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
