import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/utilities/constants/smooth_rectangular_border.dart';
import 'package:project/utilities/theme/app_colors.dart';

import '../navigation/my_navigator.dart';

class Dialogs {
  static Future<void> showSuccessDialog(
    BuildContext context,
  ) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(cornerRadius: 22),
              ),
              backgroundColor: AppColors.white,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                    child: Column(
                      children: [
                        const SizedBox(width: 20),
                        const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: AppColors.scienceBlue,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),

                            Text(
                              "Signing In Successful",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: AppColors.royalBlue, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 20),

                            Text(
                              "Please wait...",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.midGrey,
                                  )
                            ),

                            const SizedBox(height: 8),

                            Text(
                              " You will be directed to the homepage soon.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.midGrey,
                                  )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  static Future<void> cancelledDialog(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
          ),
          backgroundColor: AppColors.zircon,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Lottie.asset("", height: 120, width: 120),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Payment Cancelled....",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.darkJungleGreen, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        );
      },
    );

    await Future.delayed(const Duration(seconds: 3));
    MyNavigator.pop();
  }

  static Future<void> errorDialog(BuildContext context, {String? title}) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
          ),
          backgroundColor: AppColors.zircon,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Lottie.asset("AssetPath.errorLottie", height: 120, width: 120),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    title ?? "Something Went Wrong!",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.darkJungleGreen, fontWeight: FontWeight.w500),
                  ),
                  ElevatedButton(
                    onPressed: () => MyNavigator.pop(),
                    child: const Text("Try Again"),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
