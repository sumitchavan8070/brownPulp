import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/utilities/constants/custom_text_field.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/theme/button_decoration.dart';
import 'package:project/utilities/validators/generic_validator.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController phoneController = TextEditingController();
  bool showNumberEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  children: [
                    // SvgPicture.asset(AssetPath.authLogo),
                    const SizedBox(height: 50),
                    Text(
                      "Forgot Your Password?",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.midGrey,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Please enter your registered Phone Number & wesent an OTP Verification code to reset your password.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.midGrey,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: AppBoxDecoration.getBorderBoxDecoration(
                  showShadow: false,
                  borderRadius: 18,
                  borderColor: AppColors.pastalGrey,
                  color: AppColors.pastalGrey.withOpacity(0.2),
                ),
                child: CustomTextField(
                  hintText: "Enter your phone number",
                  controller: phoneController,
                  fillColor: AppColors.transparent,
                  onChanged: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        showNumberEnabled = false;
                        GenericValidator.numberValidator(
                          value: value,
                          message: "Please enter valid number",
                        );
                      });
                    } else {
                      setState(() {
                        showNumberEnabled = true;
                      });
                    }
                  },
                  prefix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      showNumberEnabled ? AssetPath.activeCall : AssetPath.inActiveCall,
                    ),
                  ),
                  validator: (value) {
                    return GenericValidator.required(
                          value: value,
                          message: "Please enter name",
                        ) ??
                        GenericValidator.numberValidator(
                          value: value,
                          message: "Please enter valid number",
                        );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
          Column(
            children: [
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
                    "Proceed",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
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
                      recognizer: TapGestureRecognizer()
                        ..onTap = (() {
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
              const SizedBox(height: 40),
            ],
          )
        ],
      ),
    );
    ;
  }
}
