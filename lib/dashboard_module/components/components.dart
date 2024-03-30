import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';

typedef CategoryNavigator = void Function();

class CategoryComponent extends StatelessWidget {
  final String title;
  final String subTitle;
  final CategoryNavigator onTap;

  const CategoryComponent({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.onyx,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.fadedOrange,
                      ),
                ),
                const SizedBox(width: 14),
                SvgPicture.asset(
                  AssetPath.arrow,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
