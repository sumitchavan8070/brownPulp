import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/utilities/constants/key_value_pair.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/theme/button_decoration.dart';

class LoginWithNetwork extends StatefulWidget {
  const LoginWithNetwork({super.key});

  @override
  State<LoginWithNetwork> createState() => _LoginWithNetworkState();
}

class _LoginWithNetworkState extends State<LoginWithNetwork> {
  final signUpData = [
    KeyValuePair(
      key: "google",
      value: "Sign In Using Google Account",
      path: AssetPath.google,
    ),
    KeyValuePair(
      key: "facebook",
      value: "Sign In Using Facebook Account",
      path: AssetPath.fb,
    ),
    // KeyValuePair(
    //   key: "apple",
    //   value: "Sign In Using Apple Account",
    //   path: AssetPath.apple,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                children: [
                  SvgPicture.asset(AssetPath.authLogo),
                  const SizedBox(height: 20),
                  Text(
                    "Let’s Get You Started With brownpulp",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.midGrey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ...List.generate(
              signUpData.length,
              (index) {
                final data = signUpData[index];
                return Container(
                  height: 70,
                  margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  decoration: AppBoxDecoration.getBorderBoxDecoration(
                    showShadow: false,
                    color: AppColors.white,
                    borderRadius: 12,
                    borderColor: AppColors.porcelain,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        child: SvgPicture.asset(data.path ?? ""),
                      ),
                      Text(
                        data.value,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.midGrey,
                            ),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: ElevatedButton(
                onPressed: () {
                  MyNavigator.pushReplacementNamed(GoPaths.loginScreen);
                },
                // Button label
                style: getElevatedButtonStyle(
                  borderRadius: 40,
                  foregroundColor: AppColors.roseEbony,
                  backgroundColor: AppColors.roseEbony,
                  elevation: 0,
                ),
                child: Text(
                  "Sign In Using Password ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'New To brownpulp?   ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.midGrey,
                        ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = (() {
                      MyNavigator.pushReplacementNamed(GoPaths.signUpView);
                    }),
                    text: 'Register Now',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.doggerBlule,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
