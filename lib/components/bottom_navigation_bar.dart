import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.gainsBoro, // Adjust color as needed
            width: 1.0, // Adjust thickness as needed
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            AssetPath.homeActive,
          ),
          SvgPicture.asset(
            AssetPath.cart,
          ),
          SvgPicture.asset(
            AssetPath.like,
          ),
          SvgPicture.asset(
            AssetPath.profile,
          ),
        ],
      ),
    );
  }
}
