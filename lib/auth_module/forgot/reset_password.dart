import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/utilities/constants/custom_text_field.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/theme/button_decoration.dart';
import 'package:project/utilities/validators/generic_validator.dart';

class RestPasswordScreen extends StatefulWidget {
  const RestPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RestPasswordScreen> createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool showPass = false;
  bool showConfirmPass = false;
  final _formKey = GlobalKey<FormState>();
  bool showPassEnabled = false;
  bool showConfirmPassEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  children: [
                    // SvgPicture.asset(AssetPath.authLogo),
                    const SizedBox(height: 20),
                    Text(
                      "Reset Your Password",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: AppColors.midGrey,
                      ),
                    ),
                    Text(
                      "Please enter your new password",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: AppColors.midGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            child: Text(
                              "Password",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: AppBoxDecoration.getBorderBoxDecoration(
                              showShadow: false,
                              borderRadius: 18,
                              borderColor: AppColors.pastalGrey,
                              color: AppColors.pastalGrey.withOpacity(0.2),
                            ),
                            child: CustomTextField(
                              hintText: "Password",
                              controller: passwordController,
                              obscureText: !showPass, // Negate showPass here
                              fillColor: AppColors.transparent,
                              onChanged: (value) {
                                if (value!.isEmpty) {
                                  showPassEnabled = false;
                                  setState(() {});
                                } else {
                                  showPassEnabled = true;
                                  setState(() {});
                                }
                              },
                              validator: (value) {
                                return GenericValidator.required(
                                  value: value,
                                  message: "Please enter password",
                                );
                              },
                              prefix: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  showPassEnabled ? AssetPath.lockEnabled : AssetPath.lock,
                                ),
                              ),
                              suffix: passwordController.text.isNotEmpty
                                  ? Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showPass = !showPass;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    showPass ? AssetPath.show : AssetPath.hide,
                                  ),
                                ),
                              )
                                  : SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            child: Text(
                              "Confirm Password",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: AppBoxDecoration.getBorderBoxDecoration(
                              showShadow: false,
                              borderRadius: 18,
                              borderColor: AppColors.pastalGrey,
                              color: AppColors.pastalGrey.withOpacity(0.2),
                            ),
                            child: CustomTextField(
                              hintText: "Confirm Password",
                              controller: confirmPasswordController,
                              obscureText: !showConfirmPass, // Negate showConfirmPass here
                              fillColor: AppColors.transparent,
                              onChanged: (value) {
                                if (value!.isEmpty) {
                                  showConfirmPassEnabled = false;
                                  setState(() {});
                                } else {
                                  showConfirmPassEnabled = true;
                                  setState(() {});
                                }
                              },
                              validator: (value) {
                                return GenericValidator.required(
                                  value: value,
                                  message: "Please enter password",
                                );
                              },
                              prefix: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  showConfirmPassEnabled ? AssetPath.lockEnabled : AssetPath.lock,
                                ),
                              ),
                              suffix: confirmPasswordController.text.isNotEmpty
                                  ? Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showConfirmPass = !showConfirmPass;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    showConfirmPass ? AssetPath.show : AssetPath.hide,

                                  ),
                                ),
                              )
                                  : SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      debugPrint("check the values for login ");
                    }

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
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
