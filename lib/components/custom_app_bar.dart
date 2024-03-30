import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';

typedef ActionOnTap = void Function();

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? bgColor;
  final Color? leadingIconColor;
  final double? elevation;
  final bool? centerTitle;
  final bool isProfileView;
  final bool leadingPopAll;
  final ActionOnTap? actionOnTap;
  final Widget? action;

  const CustomAppBar({
    super.key,
    required this.title,
    this.bgColor,
    this.elevation,
    this.centerTitle,
    this.leadingPopAll = false,
    this.actionOnTap,
    required this.isProfileView,
    this.action,
    this.leadingIconColor,
  });

  final profile = const Padding(
    padding: EdgeInsets.symmetric(horizontal: 6),
    child: CircleAvatar(
      backgroundImage: AssetImage(AssetPath.search),
      radius: 12,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
      ),
      centerTitle: centerTitle ?? false,
      elevation: elevation ?? 0,
      backgroundColor: bgColor ?? AppColors.zircon,
      leading: isProfileView
          ? profile
          : GestureDetector(
              onTap: () {
                if (leadingPopAll == true) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                } else {
                  context.pop();
                }
              },
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: leadingIconColor ?? AppColors.black,
              ),
            ),
      actions: [
        isProfileView
            ? IconButton(
                icon: Icon(
                  Icons.logout,
                  color: isProfileView ? AppColors.white : AppColors.black,
                ),
                onPressed: actionOnTap,
              )
            : Center(
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: action,
                ),
              ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
