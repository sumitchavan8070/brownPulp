import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';

class CachedImageNetworkContainer extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;
  final EdgeInsets? containerPadding;
  final Widget placeHolder;
  final Decoration? decoration;
  final BoxFit fit;

  const CachedImageNetworkContainer({
    super.key,
    required this.url,
    this.height = 54,
    this.width = 54,
    this.containerPadding,
    required this.placeHolder,
    this.decoration,
    this.fit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: containerPadding,
      height: height,
      width: width,
      decoration: decoration ??
          AppBoxDecoration.getBoxDecoration(
            showShadow: false,
            color: AppColors.white,
          ),
      child: url != null || url?.isNotEmpty == true
          ? CachedNetworkImage(
              imageUrl: url!,
              fit: fit,
              placeholder: (context, url) {
                return placeHolder;
              },
              errorWidget: (context, url, error) {
                return placeHolder;
              },
            )
          : placeHolder,
    );
  }
}

Widget buildPlaceholder({required String name, required BuildContext context, color = AppColors.toryBlue}) {
  final initial = name.isNotEmpty ? name[0] : '';
  return Center(
    child: Text(
      initial,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
    ),
  );
}

Widget buildPlaceholderAsset({required String assetPath}) {
  return Image.asset(
    fit: BoxFit.fill,
    assetPath,
    scale: 2,
  );
}

Widget buildPlaceholderIcon({required IconData icon}) {
  return Center(
    child: Icon(
      icon,
      size: 30,
    ),
  );
}
